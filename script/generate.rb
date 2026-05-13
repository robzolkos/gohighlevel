#!/usr/bin/env ruby
# frozen_string_literal: true

# Emits Ruby resource + model code from a vendored OpenAPI app spec.
#
# Usage:
#   script/generate.rb                # all apps
#   script/generate.rb contacts       # one app
#   script/generate.rb contacts opportunities
#
# Output lands under lib/high_level/resources/<app>.rb and
# lib/high_level/models/<app>/*.rb. Re-running with the same spec SHA is
# byte-identical (idempotent); the drift check (Phase 9) relies on that.

require "json"
require "fileutils"
require "open3"

ROOT = File.expand_path("..", __dir__)
SPECS_DIR = File.join(ROOT, "vendor/openapi/apps")
RESOURCES_DIR = File.join(ROOT, "lib/high_level/resources")
MODELS_DIR = File.join(ROOT, "lib/high_level/models")
VERSION_FILE = File.join(ROOT, "vendor/openapi/VERSION")

class Generator
  HTTP_METHODS = %w[get post put patch delete].freeze
  SKIP_HEADER_PARAMS = %w[Version version].freeze

  def initialize(app_name, sha:)
    @app_name = app_name
    @sha = sha
    @spec = JSON.parse(File.read(File.join(SPECS_DIR, "#{app_name}.json")))
  end

  def generate
    emit_resource
    emit_models
  end

  private

  def emit_resource
    operations = collect_operations
    path = File.join(RESOURCES_DIR, "#{@app_name}.rb")
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, render_resource(operations))
  end

  def emit_models
    schemas = @spec.dig("components", "schemas") || {}
    dir = File.join(MODELS_DIR, @app_name)
    FileUtils.mkdir_p(dir)
    schemas.each do |name, schema|
      next unless object_schema?(schema)

      File.write(File.join(dir, "#{snake_case(name)}.rb"), render_model(name, schema))
    end
  end

  def collect_operations
    @spec.fetch("paths").flat_map do |path, methods|
      HTTP_METHODS.filter_map do |verb|
        op = methods[verb]
        next unless op

        build_operation(verb, path, op)
      end
    end
  end

  def build_operation(verb, path, op)
    params = op["parameters"] || []
    {
      method_name: snake_case(op.fetch("operationId")),
      summary: op["summary"],
      description: op["description"],
      verb: verb.to_sym,
      path: path,
      path_params: params.select { |p| p["in"] == "path" },
      query_params: params.select { |p| p["in"] == "query" },
      header_params: params.select { |p| p["in"] == "header" && !SKIP_HEADER_PARAMS.include?(p["name"]) },
      body_required: !op["requestBody"].nil?,
      security: (op["security"] || []).flat_map(&:keys).uniq
    }
  end

  def render_resource(operations)
    class_name = pascal_case(@app_name)
    methods = operations.map { |op| render_method(op) }.join("\n\n")

    <<~RUBY
      # frozen_string_literal: true
      # GENERATED FROM vendor/openapi/apps/#{@app_name}.json @ #{@sha}
      # DO NOT EDIT — regenerate via bin/generate.

      module HighLevel
        module Resources
          class #{class_name} < Base
      #{methods.gsub(/^/, "      ").gsub(/^\s+$/, "")}
          end
        end
      end
    RUBY
  end

  def render_method(op)
    kwargs = method_kwargs(op)
    body_lines = method_body(op)
    yard = render_yard(op)

    [
      yard,
      "def #{op[:method_name]}(#{kwargs})",
      *body_lines.map { |l| "  #{l}" },
      "end"
    ].reject(&:empty?).join("\n")
  end

  def method_kwargs(op)
    parts = op[:path_params].map { |p| "#{snake_case(p["name"])}:" } +
            op[:query_params].map { |p| "#{snake_case(p["name"])}: nil" } +
            op[:header_params].map { |p| "#{snake_case(p["name"])}: nil" }
    parts << "body:" if op[:body_required]
    parts << "**_opts"
    parts.join(", ")
  end

  def method_body(op)
    lines = []
    lines << "request("
    lines << "  method: :#{op[:verb]},"
    lines << "  path: #{render_path(op)},"
    lines << "  security: #{op[:security].inspect},"
    if op[:query_params].any?
      query_pairs = op[:query_params].map { |p| "#{p["name"].inspect} => #{snake_case(p["name"])}" }
      lines << "  params: { #{query_pairs.join(", ")} }.compact,"
    end
    if op[:header_params].any?
      header_pairs = op[:header_params].map { |p| "#{p["name"].inspect} => #{snake_case(p["name"])}" }
      lines << "  headers: { #{header_pairs.join(", ")} }.compact,"
    end
    lines << "  body: body," if op[:body_required]
    lines << ")"
    lines
  end

  def render_path(op)
    interpolated = op[:path].gsub(/\{(\w+)\}/) do
      "\#{#{snake_case(Regexp.last_match(1))}}"
    end
    %("#{interpolated}")
  end

  def render_yard(op)
    lines = []
    if op[:summary] && !op[:summary].empty?
      summary_first, *rest = op[:summary].split("\n")
      lines << "# #{summary_first}"
      rest.each { |line| lines << "# #{line}" }
    end
    if op[:description] && !op[:description].empty? && op[:description] != op[:summary]
      lines << "#" unless lines.empty?
      op[:description].split("\n").each { |line| lines << "# #{line}".rstrip }
    end
    lines.join("\n")
  end

  def render_model(name, schema)
    fields = (schema["properties"] || {}).keys.map { |k| ":#{snake_case(k)}" }
    body = fields.any? ? "Data.define(#{fields.join(", ")})" : "Data.define"

    <<~RUBY
      # frozen_string_literal: true
      # GENERATED FROM vendor/openapi/apps/#{@app_name}.json @ #{@sha}
      # DO NOT EDIT — regenerate via bin/generate.

      module HighLevel
        module Models
          module #{pascal_case(@app_name)}
            #{name} = #{body}
          end
        end
      end
    RUBY
  end

  def object_schema?(schema)
    schema.is_a?(Hash) && (schema["type"] == "object" || schema["properties"].is_a?(Hash))
  end

  def snake_case(str)
    str.to_s
       .gsub("-", "_")
       .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
       .gsub(/([a-z\d])([A-Z])/, '\1_\2')
       .downcase
  end

  def pascal_case(str)
    str.to_s.split(/[-_]/).map(&:capitalize).join
  end
end

def read_pinned_sha
  return "unknown" unless File.exist?(VERSION_FILE)

  File.read(VERSION_FILE).lines.first&.strip || "unknown"
end

def rubocop_autocorrect!(files)
  return if files.empty?

  cmd = ["bundle", "exec", "rubocop", "-A", "--fail-level", "error", *files]
  out, status = Open3.capture2e(*cmd, chdir: ROOT)
  return if status.success?

  warn out
  warn "rubocop autocorrect failed — generated files may still need manual review"
end

def main
  filter = ARGV.dup
  sha = read_pinned_sha
  app_names = if filter.empty?
                Dir.glob(File.join(SPECS_DIR, "*.json")).map { |p| File.basename(p, ".json") }
              else
                filter
              end

  changed = []
  app_names.each do |app|
    spec_path = File.join(SPECS_DIR, "#{app}.json")
    unless File.exist?(spec_path)
      warn "no spec for app: #{app} (#{spec_path})"
      next
    end
    Generator.new(app, sha: sha).generate
    changed << File.join("lib/high_level/resources/#{app}.rb")
    changed << File.join("lib/high_level/models/#{app}/")
    puts "generated #{app}"
  end

  rubocop_autocorrect!(changed)
end

main if __FILE__ == $PROGRAM_NAME
