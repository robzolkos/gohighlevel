# frozen_string_literal: true

module HighLevel
  # Base class for every error the SDK raises. Carries the HTTP context
  # of the failed request where one is available.
  #
  # @!attribute [r] status
  #   @return [Integer, nil] the HTTP status code, when the error came
  #     from a response
  # @!attribute [r] response_body
  #   @return [Object, nil] the parsed response body, when available
  # @!attribute [r] request_id
  #   @return [String, nil] the +x-request-id+ response header, when present
  class Error < StandardError
    attr_reader :status, :response_body, :request_id

    # @param message [String, nil] human-readable error message
    # @param status [Integer, nil] HTTP status code
    # @param response_body [Object, nil] parsed response body
    # @param request_id [String, nil] the +x-request-id+ header value
    def initialize(message = nil, status: nil, response_body: nil, request_id: nil)
      super(message)
      @status = status
      @response_body = response_body
      @request_id = request_id
    end
  end

  # Raised on a missing or malformed client configuration.
  class ConfigurationError < Error; end
  # Raised on a transport-level failure (connection refused, timeout, ...).
  class NetworkError < Error; end
  # Raised on an HTTP 400 response.
  class BadRequestError < Error; end
  # Raised on an HTTP 401 response.
  class UnauthorizedError < Error; end
  # Raised on an HTTP 403 response.
  class ForbiddenError < Error; end
  # Raised on an HTTP 404 response.
  class NotFoundError < Error; end
  # Raised on an HTTP 422 response.
  class UnprocessableEntityError < Error; end
  # Raised on an HTTP 429 response.
  class RateLimitError < Error; end
  # Raised on an HTTP 5xx response.
  class ServerError < Error; end
end
