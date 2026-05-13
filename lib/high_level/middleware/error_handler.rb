# frozen_string_literal: true

module HighLevel
  module Middleware
    class ErrorHandler < Faraday::Middleware
      STATUS_MAP = {
        400 => HighLevel::BadRequestError,
        401 => HighLevel::UnauthorizedError,
        403 => HighLevel::ForbiddenError,
        404 => HighLevel::NotFoundError,
        422 => HighLevel::UnprocessableEntityError,
        429 => HighLevel::RateLimitError
      }.freeze

      def on_complete(env)
        return if env.status.between?(200, 299)

        klass = STATUS_MAP[env.status] ||
                (env.status >= 500 ? HighLevel::ServerError : HighLevel::Error)

        raise klass.new(
          "HTTP #{env.status} on #{env.method.to_s.upcase} #{env.url&.path}",
          status: env.status,
          response_body: env.body,
          request_id: request_id_from(env)
        )
      end

      private

      def request_id_from(env)
        headers = env.response_headers
        return nil unless headers

        headers["x-request-id"] || headers["X-Request-Id"]
      end
    end
  end
end
