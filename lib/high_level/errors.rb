# frozen_string_literal: true

module HighLevel
  class Error < StandardError
    attr_reader :status, :response_body, :request_id

    def initialize(message = nil, status: nil, response_body: nil, request_id: nil)
      super(message)
      @status = status
      @response_body = response_body
      @request_id = request_id
    end
  end

  class ConfigurationError < Error; end
  class NetworkError < Error; end
  class BadRequestError < Error; end
  class UnauthorizedError < Error; end
  class ForbiddenError < Error; end
  class NotFoundError < Error; end
  class UnprocessableEntityError < Error; end
  class RateLimitError < Error; end
  class ServerError < Error; end
end
