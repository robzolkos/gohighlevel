# frozen_string_literal: true

module HighLevel
  module Middleware
    class Authentication < Faraday::Middleware
      CONTEXT_KEY = :high_level_security

      def initialize(app, config:, resolver: nil, storage: nil)
        super(app)
        @config = config
        @resolver = resolver || TokenResolver.new(config: config, storage: storage)
      end

      def on_request(env)
        env.request_headers["Version"] ||= @config.api_version
        return if env.request_headers["Authorization"]

        env.request_headers["Authorization"] = "Bearer #{resolve_token(env)}"
      end

      private

      def resolve_token(env)
        ctx = security_context(env)
        return simple_priority_token unless ctx

        @resolver.resolve(
          security_requirements: ctx[:security_requirements] || [],
          headers: env.request_headers,
          query: parse_query(env.url&.query),
          body: env.body,
          preference: ctx[:preference]
        ).token
      end

      def security_context(env)
        opts = env.request
        return nil unless opts.respond_to?(:context)

        ctx = opts.context
        return nil unless ctx.is_a?(Hash)

        ctx[CONTEXT_KEY]
      end

      def simple_priority_token
        @config.private_integration_token ||
          @config.agency_access_token ||
          @config.location_access_token ||
          raise(HighLevel::ConfigurationError, "no token available for request")
      end

      def parse_query(query_string)
        return {} if query_string.nil? || query_string.empty?

        URI.decode_www_form(query_string).to_h
      end
    end
  end
end
