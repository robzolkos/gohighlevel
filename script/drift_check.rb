#!/usr/bin/env ruby
# frozen_string_literal: true

# Drift check for the generated resource layer.
#
# Two modes:
#   (default) Local check — regenerate against vendor/openapi/ as pinned
#             in script/fetch_specs.rb, then diff against committed code.
#             Catches "did you forget to commit your regen?"
#   --upstream Upstream check — re-checkout vendor/openapi/ at the
#             upstream HEAD SHA, regenerate, diff. Catches API changes
#             we haven't bumped to yet. Used by the weekly CI cron.
#
# In both modes the script always restores vendor/openapi/ and the
# regenerated lib/high_level/{resources,models,resource_registry.rb} to
# their pre-run state on exit, so the working tree is unchanged whether
# drift was found or not. Exit 0 = no drift, 1 = drift detected.

require "fileutils"
require "open3"
require "tmpdir"

ROOT = File.expand_path("..", __dir__)
VENDOR_OPENAPI = File.join(ROOT, "vendor/openapi")
WATCHED = %w[
  lib/high_level/resources
  lib/high_level/models
  lib/high_level/resource_registry.rb
].freeze
REPO_URL = "https://github.com/GoHighLevel/highlevel-api-docs.git"

def sh!(cmd, cwd: ROOT, allow_fail: false)
  out, status = Open3.capture2e(*cmd, chdir: cwd)
  if !status.success? && !allow_fail
    warn out
    abort("command failed: #{cmd.join(" ")}")
  end
  [out, status]
end

def snapshot_to(snapshot_dir)
  WATCHED.each do |rel|
    src = File.join(ROOT, rel)
    dst = File.join(snapshot_dir, rel)
    FileUtils.mkdir_p(File.dirname(dst))
    next unless File.exist?(src)

    if File.directory?(src)
      FileUtils.cp_r(src, dst, preserve: true)
    else
      FileUtils.cp(src, dst, preserve: true)
    end
  end
end

def restore_from(snapshot_dir)
  WATCHED.each do |rel|
    dst = File.join(ROOT, rel)
    src = File.join(snapshot_dir, rel)
    FileUtils.rm_rf(dst)
    next unless File.exist?(src)

    FileUtils.mkdir_p(File.dirname(dst))
    if File.directory?(src)
      FileUtils.cp_r(src, dst, preserve: true)
    else
      FileUtils.cp(src, dst, preserve: true)
    end
  end
end

def diff_summary(snapshot_dir)
  WATCHED.flat_map do |rel|
    snap = File.join(snapshot_dir, rel)
    cur = File.join(ROOT, rel)
    out, status = if File.directory?(snap) || File.directory?(cur)
                    sh!(["diff", "-rq", snap, cur], allow_fail: true)
                  else
                    sh!(["diff", "-q", snap, cur], allow_fail: true)
                  end
    status.success? ? [] : out.lines.map(&:rstrip)
  end
end

def upstream_head_sha
  out, = sh!(["git", "ls-remote", REPO_URL, "HEAD"])
  out.split.first
end

def vendor_head_sha
  sh!(%w[git rev-parse HEAD], cwd: VENDOR_OPENAPI)[0].strip
end

def with_vendor_checked_out_at(sha)
  original = vendor_head_sha
  if original == sha
    yield
    return
  end

  sh!(["git", "fetch", "--depth", "1", "--filter=blob:none", "origin", sha], cwd: VENDOR_OPENAPI)
  sh!(["git", "checkout", "-q", sha], cwd: VENDOR_OPENAPI)
  begin
    yield
  ensure
    sh!(["git", "checkout", "-q", original], cwd: VENDOR_OPENAPI)
  end
end

def report_drift(diffs, mode_label)
  warn "✗ drift detected (#{mode_label})"
  diffs.first(50).each { |line| warn "  #{line}" }
  warn "  ... (#{diffs.length - 50} more)" if diffs.length > 50
  warn ""
  if mode_label.start_with?("upstream")
    warn "to resolve: bump PIN_SHA in script/fetch_specs.rb,"
    warn "             run bin/sync-spec && bin/generate, commit the diff."
  else
    warn "to resolve: run bin/generate and commit the diff."
  end
end

def main
  upstream = ARGV.include?("--upstream")

  unless File.directory?(File.join(VENDOR_OPENAPI, ".git"))
    abort "vendor/openapi/ is not populated. Run bin/sync-spec first."
  end

  Dir.mktmpdir("ghl-drift-") do |snapshot|
    snapshot_to(snapshot)
    label =
      if upstream
        head = upstream_head_sha
        current = vendor_head_sha
        if head == current
          puts "✓ already at upstream HEAD #{head} — no drift to check."
          exit 0
        end
        "upstream HEAD #{head[0, 12]} vs pinned #{current[0, 12]}"
      else
        "regenerated against pinned #{vendor_head_sha[0, 12]}"
      end

    begin
      if upstream
        with_vendor_checked_out_at(upstream_head_sha) { sh!([File.join(ROOT, "bin/generate")]) }
      else
        sh!([File.join(ROOT, "bin/generate")])
      end

      diffs = diff_summary(snapshot)

      if diffs.empty?
        puts "✓ no drift (#{label})"
        exit 0
      end

      report_drift(diffs, label)
      exit 1
    ensure
      restore_from(snapshot)
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
