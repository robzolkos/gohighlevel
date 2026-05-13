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

  context "when the request carries security context" do
    def env_with_context(headers: {}, body: nil, query: nil, context: nil)
      url = URI.parse("https://example.com/x")
      url.query = URI.encode_www_form(query) if query
      env = Faraday::Env.from(
        request_headers: Faraday::Utils::Headers.new(headers),
        url: url,
        body: body
      )
      env.request = Faraday::RequestOptions.new
      env.request.context = { HighLevel::Middleware::Authentication::CONTEXT_KEY => context } if context
      env
    end

    it "uses the resolver and prefers agency token for Agency-Access-Only" do
      config = HighLevel::Configuration.new(
        agency_access_token: "ag-1",
        location_access_token: "loc-1"
      )
      middleware = described_class.new(app, config: config)
      env = env_with_context(context: { security_requirements: ["Agency-Access-Only"] })

      middleware.on_request(env)
      expect(env.request_headers["Authorization"]).to eq("Bearer ag-1")
    end

    it "raises when the resolver cannot satisfy the requirement" do
      config = HighLevel::Configuration.new(agency_access_token: "ag-1")
      middleware = described_class.new(app, config: config)
      env = env_with_context(context: { security_requirements: ["Location-Access-Only"] })

      expect { middleware.on_request(env) }.to raise_error(HighLevel::ConfigurationError)
    end
  end
end
