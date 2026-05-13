# frozen_string_literal: true

require "test_helper"
require "json"

module HighLevel
  class TokenResolverTest < Minitest::Test
    FIXTURES = JSON.parse(File.read(File.expand_path("../fixtures/token_resolution.json", __dir__)))

    class StubStorage
      def initialize(sessions = {})
        @sessions = sessions
      end

      def get_session(resource_id)
        @sessions[resource_id]
      end
    end

    def self.symbolize_preference(value)
      value&.to_sym
    end

    def self.test_name(prefix, raw)
      :"test_#{prefix}_#{raw.gsub(/\W+/, "_").downcase}"
    end

    FIXTURES.fetch("resolve").each do |fixture|
      define_method(test_name("resolve", fixture.fetch("name"))) do
        config = Configuration.new(**(fixture["config"] || {}).transform_keys(&:to_sym))
        resolver = TokenResolver.new(config: config)
        args = fixture.fetch("args")
        expected = fixture.fetch("expect")

        call = lambda do
          resolver.resolve(
            security_requirements: args["security_requirements"] || [],
            headers: args["headers"] || {},
            query: args["query"] || {},
            body: args["body"] || {},
            preference: self.class.symbolize_preference(args["preference"])
          )
        end

        if expected["error"]
          error_class = HighLevel.const_get(expected["error"])
          error = assert_raises(error_class) { call.call }
          assert_includes error.message, expected["message_includes"] if expected["message_includes"]
        else
          result = call.call
          assert_equal expected.fetch("token"), result.token
          assert_equal expected.fetch("source").to_sym, result.source
        end
      end
    end

    FIXTURES.fetch("extract_resource_id").each do |fixture|
      define_method(test_name("extract_resource_id", fixture.fetch("name"))) do
        config = Configuration.new(private_integration_token: "irrelevant")
        resolver = TokenResolver.new(config: config)
        args = fixture.fetch("args")

        result = resolver.extract_resource_id(
          security_requirements: args["security_requirements"] || [],
          headers: args["headers"] || {},
          query: args["query"] || {},
          body: args["body"] || {},
          preference: self.class.symbolize_preference(args["preference"])
        )

        expected = fixture.fetch("expect")
        if expected.nil?
          assert_nil result
        else
          assert_equal expected, result
        end
      end
    end

    def test_storage_fallback_with_symbol_keys
      storage = StubStorage.new("loc-1" => { access_token: "stored-loc" })
      resolver = TokenResolver.new(config: Configuration.new, storage: storage)

      result = resolver.resolve(
        security_requirements: ["Location-Access-Only"],
        headers: { "x-location-id" => "loc-1" }
      )

      assert_equal "stored-loc", result.token
      assert_equal :storage, result.source
    end

    def test_storage_fallback_with_string_keys
      storage = StubStorage.new("co-1" => { "access_token" => "stored-co" })
      resolver = TokenResolver.new(config: Configuration.new, storage: storage)

      result = resolver.resolve(
        security_requirements: ["Agency-Access-Only"],
        headers: { "x-company-id" => "co-1" }
      )

      assert_equal "stored-co", result.token
    end

    def test_storage_returns_nil_raises
      storage = StubStorage.new
      resolver = TokenResolver.new(config: Configuration.new, storage: storage)

      assert_raises(ConfigurationError) do
        resolver.resolve(
          security_requirements: ["Location-Access-Only"],
          headers: { "x-location-id" => "loc-1" }
        )
      end
    end
  end
end
