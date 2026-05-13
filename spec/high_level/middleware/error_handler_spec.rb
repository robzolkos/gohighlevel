# frozen_string_literal: true

require "spec_helper"

RSpec.describe HighLevel::Middleware::ErrorHandler do
  let(:app) { ->(env) { env } }
  let(:middleware) { described_class.new(app) }

  def make_env(status:, body: nil, headers: {})
    Faraday::Env.from(
      status: status,
      body: body,
      response_headers: Faraday::Utils::Headers.new(headers),
      method: :get,
      url: URI.parse("https://example.com/path")
    )
  end

  it "passes through 2xx responses without raising" do
    expect { middleware.on_complete(make_env(status: 200)) }.not_to raise_error
  end

  {
    400 => HighLevel::BadRequestError,
    401 => HighLevel::UnauthorizedError,
    403 => HighLevel::ForbiddenError,
    404 => HighLevel::NotFoundError,
    422 => HighLevel::UnprocessableEntityError,
    429 => HighLevel::RateLimitError,
    500 => HighLevel::ServerError,
    503 => HighLevel::ServerError
  }.each do |status, error_class|
    it "maps HTTP #{status} to #{error_class}" do
      expect { middleware.on_complete(make_env(status: status)) }
        .to raise_error(error_class) { |e| expect(e.status).to eq(status) }
    end
  end

  it "exposes response_body and request_id on the raised error" do
    env = make_env(
      status: 422,
      body: { "msg" => "bad" },
      headers: { "x-request-id" => "req-1" }
    )

    expect { middleware.on_complete(env) }.to raise_error(HighLevel::UnprocessableEntityError) do |e|
      expect(e.response_body).to eq({ "msg" => "bad" })
      expect(e.request_id).to eq("req-1")
    end
  end

  it "falls back to HighLevel::Error for unmapped 4xx statuses" do
    expect { middleware.on_complete(make_env(status: 418)) }.to raise_error(HighLevel::Error)
  end
end
