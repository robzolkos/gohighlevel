# frozen_string_literal: true

require "test_helper"

module HighLevel
  module Middleware
    class ErrorHandlerTest < Minitest::Test
      APP = ->(env) { env }

      STATUS_MAP = {
        400 => BadRequestError,
        401 => UnauthorizedError,
        403 => ForbiddenError,
        404 => NotFoundError,
        422 => UnprocessableEntityError,
        429 => RateLimitError,
        500 => ServerError,
        503 => ServerError
      }.freeze

      def middleware
        ErrorHandler.new(APP)
      end

      def make_env(status:, body: nil, headers: {})
        Faraday::Env.from(
          status: status,
          body: body,
          response_headers: Faraday::Utils::Headers.new(headers),
          method: :get,
          url: URI.parse("https://example.com/path")
        )
      end

      def test_2xx_responses_do_not_raise
        middleware.on_complete(make_env(status: 200))
      end

      STATUS_MAP.each do |status, error_class|
        define_method(:"test_maps_#{status}_to_#{error_class.name.split("::").last}") do
          error = assert_raises(error_class) { middleware.on_complete(make_env(status: status)) }
          assert_equal status, error.status
        end
      end

      def test_exposes_response_body_and_request_id
        env = make_env(
          status: 422,
          body: { "msg" => "bad" },
          headers: { "x-request-id" => "req-1" }
        )

        error = assert_raises(UnprocessableEntityError) { middleware.on_complete(env) }
        assert_equal({ "msg" => "bad" }, error.response_body)
        assert_equal "req-1", error.request_id
      end

      def test_falls_back_to_base_error_for_unmapped_4xx
        assert_raises(Error) { middleware.on_complete(make_env(status: 418)) }
      end
    end
  end
end
