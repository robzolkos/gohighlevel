# frozen_string_literal: true

require "faraday"
require "zeitwerk"

# Ruby SDK for the HighLevel (GoHighLevel) API. Start with
# {HighLevel::Client}.
module HighLevel
end

loader = Zeitwerk::Loader.new
loader.tag = "gohighlevel"
loader.push_dir("#{__dir__}/high_level", namespace: HighLevel)
# These files define constants that don't match Zeitwerk's
# file-name-to-constant convention (a SCREAMING_CASE constant, multiple
# error classes, a top-level registry hash), so they're loaded eagerly
# rather than autoloaded.
loader.ignore("#{__dir__}/high_level/version.rb")
loader.ignore("#{__dir__}/high_level/errors.rb")
loader.ignore("#{__dir__}/high_level/resource_registry.rb")
# Two classes of files must stay autoloadable but be skipped during
# eager_load, so host apps (Rails in CI/production calling
# `Zeitwerk::Loader.eager_load_all`) don't crash on this gem:
#
# 1. Optional storage backends top-level-require gems that aren't
#    runtime deps (active_record, mongo, redis) — missing gem → LoadError.
# 2. Generated model files define acronym-style constants
#    (e.g. AdCampaignDTO) that don't match Zeitwerk's default inflection
#    (AdCampaignDto) — Zeitwerk::NameError on eager_load. They're pure
#    Data.define value objects with no side effects, so on-demand
#    autoloading via const_missing is the right strategy anyway.
loader.do_not_eager_load(
  "#{__dir__}/high_level/storage/active_record.rb",
  "#{__dir__}/high_level/storage/mongo.rb",
  "#{__dir__}/high_level/storage/redis.rb",
  "#{__dir__}/high_level/models"
)
loader.setup

require_relative "high_level/version"
require_relative "high_level/errors"
require_relative "high_level/resource_registry"
