# frozen_string_literal: true

require "spec_helper"

RSpec.describe HighLevel::Middleware::Authentication do
  let(:app) { ->(env) { env } }

  def env_with(headers: {})
    Faraday::Env.from(request_headers: Faraday::Utils::Headers.new(headers))
  end

  it "injects bearer + version headers using the private integration token" do
    config = HighLevel::Configuration.new(private_integration_token: "pit-abc")
    middleware = described_class.new(app, config: config)
    env = env_with

    middleware.on_request(env)

    expect(env.request_headers["Authorization"]).to eq("Bearer pit-abc")
    expect(env.request_headers["Version"]).to eq("2021-07-28")
  end

  it "prefers the PIT over agency and location tokens" do
    config = HighLevel::Configuration.new(
      private_integration_token: "pit-abc",
      agency_access_token: "agency",
      location_access_token: "loc"
    )
    middleware = described_class.new(app, config: config)
    env = env_with

    middleware.on_request(env)
    expect(env.request_headers["Authorization"]).to eq("Bearer pit-abc")
  end

  it "falls back to the location token when no PIT is set" do
    config = HighLevel::Configuration.new(location_access_token: "loc-xyz")
    middleware = described_class.new(app, config: config)
    env = env_with

    middleware.on_request(env)
    expect(env.request_headers["Authorization"]).to eq("Bearer loc-xyz")
  end

  it "leaves a pre-set Authorization header untouched" do
    config = HighLevel::Configuration.new(private_integration_token: "pit-abc")
    middleware = described_class.new(app, config: config)
    env = env_with(headers: { "Authorization" => "Bearer custom" })

    middleware.on_request(env)
    expect(env.request_headers["Authorization"]).to eq("Bearer custom")
  end

  it "raises ConfigurationError when no token is resolvable" do
    config = HighLevel::Configuration.new
    middleware = described_class.new(app, config: config)
    env = env_with

    expect { middleware.on_request(env) }.to raise_error(HighLevel::ConfigurationError)
  end
end
