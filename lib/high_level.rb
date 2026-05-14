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
loader.ignore("#{__dir__}/high_level/errors.rb")
loader.ignore("#{__dir__}/high_level/resource_registry.rb")
loader.setup

require_relative "high_level/errors"
require_relative "high_level/resource_registry"
