# frozen_string_literal: true

module HighLevel
  module Middleware
    # Emits an instrumentation event around every request when an
    # +instrumenter+ is configured. The instrumenter is any object
    # responding to +#instrument(name, payload, &block)+ —
    # +ActiveSupport::Notifications+ satisfies this, but so does a small
    # custom shim. When no instrumenter is configured the middleware is
    # a transparent pass-through.
    #
    # Event name: +"request.high_level"+. Payload: +:method+, +:url+,
    # and +:status+ (added after the response returns).
    class Instrumentation < Faraday::Middleware
      # The instrumentation event name.
      EVENT = "request.high_level"

      # @param app [#call] the next middleware in the stack
      # @param instrumenter [#instrument, nil] an instrumenter, or nil
      #   to make this middleware a pass-through
      def initialize(app, instrumenter:)
        super(app)
        @instrumenter = instrumenter
      end

      # Wraps the downstream call in an instrumentation event when an
      # instrumenter is configured.
      def call(env)
        return @app.call(env) if @instrumenter.nil?

        payload = { method: env.method, url: env.url.to_s }
        @instrumenter.instrument(EVENT, payload) do
          response = @app.call(env)
          payload[:status] = response.status
          response
        end
      end
    end
  end
end
