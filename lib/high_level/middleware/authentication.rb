# frozen_string_literal: true

module HighLevel
  # Faraday middleware that implements the HighLevel client's request
  # pipeline: instrumentation, 401-refresh, authentication, and typed
  # error mapping.
  module Middleware
    # Injects the +Authorization+ and +Version+ headers. When the
    # request carries a {CONTEXT_KEY} entry in its Faraday options
    # context (set by generated resource methods), the bearer token is
    # resolved through {TokenResolver}; otherwise it falls back to a
    # simple credential-priority chain.
    class Authentication < Faraday::Middleware
      # The request-options context key under which generated resource
      # code stashes the operation's security requirements.
      CONTEXT_KEY = :high_level_security

      # @param app [#call] the next middleware in the stack
      # @param config [HighLevel::Configuration] the client configuration
      # @param resolver [HighLevel::TokenResolver, nil] an explicit
      #   resolver; built from +config+/+storage+ when omitted
      # @param storage [HighLevel::Storage::Base, nil] session storage,
      #   used only when +resolver+ is not supplied
      def initialize(app, config:, resolver: nil, storage: nil)
        super(app)
        @config = config
        @resolver = resolver || TokenResolver.new(config: config, storage: storage)
      end

      # Faraday request callback. Sets the +Version+ header and, unless
      # one is already present, an +Authorization: Bearer+ header.
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
