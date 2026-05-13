# frozen_string_literal: true

require "test_helper"

module HighLevel
  module Middleware
    class AuthenticationTest < Minitest::Test
      APP = ->(env) { env }

      def env_with(headers: {})
        Faraday::Env.from(request_headers: Faraday::Utils::Headers.new(headers))
      end

      def env_with_context(headers: {}, body: nil, query: nil, context: nil)
        url = URI.parse("https://example.com/x")
        url.query = URI.encode_www_form(query) if query
        env = Faraday::Env.from(
          request_headers: Faraday::Utils::Headers.new(headers),
          url: url,
          body: body
        )
        env.request = Faraday::RequestOptions.new
        env.request.context = { Authentication::CONTEXT_KEY => context } if context
        env
      end

      def test_injects_bearer_and_version_with_pit
        config = Configuration.new(private_integration_token: "pit-abc")
        middleware = Authentication.new(APP, config: config)
        env = env_with

        middleware.on_request(env)

        assert_equal "Bearer pit-abc", env.request_headers["Authorization"]
        assert_equal "2021-07-28", env.request_headers["Version"]
      end

      def test_pit_wins_over_agency_and_location
        config = Configuration.new(
          private_integration_token: "pit-abc",
          agency_access_token: "agency",
          location_access_token: "loc"
        )
        middleware = Authentication.new(APP, config: config)
        env = env_with

        middleware.on_request(env)

        assert_equal "Bearer pit-abc", env.request_headers["Authorization"]
      end

      def test_falls_back_to_location_token_when_no_pit
        config = Configuration.new(location_access_token: "loc-xyz")
        middleware = Authentication.new(APP, config: config)
        env = env_with

        middleware.on_request(env)

        assert_equal "Bearer loc-xyz", env.request_headers["Authorization"]
      end

      def test_leaves_preset_authorization_header_untouched
        config = Configuration.new(private_integration_token: "pit-abc")
        middleware = Authentication.new(APP, config: config)
        env = env_with(headers: { "Authorization" => "Bearer custom" })

        middleware.on_request(env)

        assert_equal "Bearer custom", env.request_headers["Authorization"]
      end

      def test_raises_configuration_error_when_no_token
        config = Configuration.new
        middleware = Authentication.new(APP, config: config)
        env = env_with

        assert_raises(ConfigurationError) { middleware.on_request(env) }
      end

      def test_uses_resolver_with_security_context
        config = Configuration.new(
          agency_access_token: "ag-1",
          location_access_token: "loc-1"
        )
        middleware = Authentication.new(APP, config: config)
        env = env_with_context(context: { security_requirements: ["Agency-Access-Only"] })

        middleware.on_request(env)

        assert_equal "Bearer ag-1", env.request_headers["Authorization"]
      end

      def test_resolver_raises_when_requirement_unsatisfied
        config = Configuration.new(agency_access_token: "ag-1")
        middleware = Authentication.new(APP, config: config)
        env = env_with_context(context: { security_requirements: ["Location-Access-Only"] })

        assert_raises(ConfigurationError) { middleware.on_request(env) }
      end
    end
  end
end
