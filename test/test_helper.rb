# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/test/"

  # Generated code is mechanically derived from the OpenAPI spec — it's
  # exercised by the generator's template tests plus the resource
  # smoke/introspection tests, but it shouldn't dilute the coverage
  # number for hand-written code. (Resources::Base is hand-written.)
  add_filter "/lib/high_level/models/"
  add_filter "/lib/high_level/resource_registry.rb"
  add_filter do |src|
    src.filename.include?("/lib/high_level/resources/") &&
      !src.filename.end_with?("/base.rb")
  end

  minimum_coverage 90
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "gohighlevel"

require "minitest/autorun"
require "webmock/minitest"

WebMock.disable_net_connect!(allow_localhost: true)
