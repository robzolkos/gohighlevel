# frozen_string_literal: true

module HighLevel
  module Middleware
    class Authentication < Faraday::Middleware
      def initialize(app, config:)
        super(app)
        @config = config
      end

      def on_request(env)
        env.request_headers["Authorization"] ||= "Bearer #{resolve_token}"
        env.request_headers["Version"] ||= @config.api_version
      end

      private

      def resolve_token
        @config.private_integration_token ||
          @config.location_access_token ||
          @config.agency_access_token ||
          raise(HighLevel::ConfigurationError, "no token available for request")
      end
    end
  end
end
