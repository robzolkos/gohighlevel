# frozen_string_literal: true

module HighLevel
  module Middleware
    # Faraday middleware. On a 401 (raised by ErrorHandler as
    # UnauthorizedError), asks TokenRefresher for a new access token,
    # rewrites the Authorization header, and retries the request once.
    # The retry is marked via env.request.context so a second 401 cannot
    # loop.
    class RefreshOn401 < Faraday::Middleware
      # Request-options context key marking that a refresh+retry has
      # already been attempted, so a second 401 cannot loop.
      RETRY_FLAG = :high_level_refresh_attempted

      # @param app [#call] the next middleware in the stack
      # @param refresher [HighLevel::TokenRefresher] resolves a fresh token
      # @param resolver [HighLevel::TokenResolver] extracts the resource id
      #   from the failed request
      def initialize(app, refresher:, resolver:)
        super(app)
        @refresher = refresher
        @resolver = resolver
      end

      # Invokes the downstream stack; on a 401 attempts one refresh+retry.
      def call(env)
        @app.call(env)
      rescue HighLevel::UnauthorizedError => e
        raise e if already_retried?(env)

        resource_id = resolve_resource_id(env)
        raise e if resource_id.nil?

        new_token = @refresher.refresh_for(resource_id: resource_id)
        raise e if new_token.nil?

        mark_retried(env)
        env.request_headers["Authorization"] = "Bearer #{new_token}"
        @app.call(env)
      end

      private

      def already_retried?(env)
        ctx = env.request&.context
        ctx.is_a?(Hash) && ctx[RETRY_FLAG] == true
      end

      def mark_retried(env)
        env.request ||= Faraday::RequestOptions.new
        env.request.context ||= {}
        env.request.context[RETRY_FLAG] = true
      end

      def resolve_resource_id(env)
        ctx = env.request&.context
        security = ctx.is_a?(Hash) ? ctx[Authentication::CONTEXT_KEY] : nil

        @resolver.extract_resource_id(
          security_requirements: security&.dig(:security_requirements) || [],
          headers: env.request_headers,
          query: parse_query(env.url&.query),
          body: env.body,
          preference: security&.dig(:preference)
        )
      end

      def parse_query(query_string)
        return {} if query_string.nil? || query_string.empty?

        URI.decode_www_form(query_string).to_h
      end
    end
  end
end
