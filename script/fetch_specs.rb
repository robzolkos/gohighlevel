#!/usr/bin/env ruby
# frozen_string_literal: true

# Fetch the official HighLevel OpenAPI specs into vendor/openapi/ at a
# pinned SHA. Drives the resource generator (Phases 7-8). Idempotent:
# re-running with the same SHA does nothing.
#
# To bump the pin, edit PIN_SHA below, then run this script.

require "fileutils"
require "open3"
require "time"

REPO = "https://github.com/GoHighLevel/highlevel-api-docs.git"
PIN_SHA = "192cd68b065a7423c543d82721eb8644cdc883c7"
ROOT = File.expand_path("..", __dir__)
DEST = File.join(ROOT, "vendor/openapi")
VERSION_FILE = File.join(DEST, "VERSION")

def sh!(cmd, cwd: nil)
  out, status = Open3.capture2e(*cmd, chdir: cwd || Dir.pwd)
  unless status.success?
    warn out
    abort("command failed: #{cmd.join(" ")}")
  end
  out
end

def current_sha
  return nil unless File.directory?(File.join(DEST, ".git"))

  sh!(%w[git rev-parse HEAD], cwd: DEST).strip
end

def write_version_file(sha)
  File.write(VERSION_FILE, <<~VERSION)
    #{sha}
    fetched_at=#{Time.now.utc.iso8601}
    source=#{REPO}
  VERSION
end

def version_file_pinned_at?(sha)
  return false unless File.exist?(VERSION_FILE)

  File.read(VERSION_FILE).lines.first&.strip == sha
end

FileUtils.mkdir_p(DEST)

if current_sha == PIN_SHA && version_file_pinned_at?(PIN_SHA)
  puts "OpenAPI specs already at #{PIN_SHA} — nothing to do."
  exit 0
elsif current_sha == PIN_SHA
  puts "OpenAPI specs already at #{PIN_SHA} — refreshing VERSION."
elsif File.directory?(File.join(DEST, ".git"))
  sh!(["git", "fetch", "--depth", "1", "origin", PIN_SHA], cwd: DEST)
  sh!(["git", "checkout", "-q", PIN_SHA], cwd: DEST)
  puts "OpenAPI specs updated to #{PIN_SHA}"
else
  # `git clone` refuses a non-empty target (our committed .gitkeep), so
  # init-in-place then fetch the pinned SHA.
  sh!(%w[git init -q], cwd: DEST)
  sh!(["git", "remote", "add", "origin", REPO], cwd: DEST)
  sh!(["git", "fetch", "--depth", "1", "--filter=blob:none", "origin", PIN_SHA], cwd: DEST)
  sh!(["git", "checkout", "-q", PIN_SHA], cwd: DEST)
  puts "OpenAPI specs cloned at #{PIN_SHA}"
end

write_version_file(PIN_SHA)
puts "  → wrote #{VERSION_FILE}"
