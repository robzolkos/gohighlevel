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
loader.setup

require_relative "high_level/version"
require_relative "high_level/errors"
require_relative "high_level/resource_registry"
