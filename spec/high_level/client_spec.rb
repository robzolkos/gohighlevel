# frozen_string_literal: true

require "spec_helper"

RSpec.describe HighLevel::Client do
  describe "validation" do
    it "raises ConfigurationError when no credentials are supplied" do
      expect { described_class.new }.to raise_error(HighLevel::ConfigurationError)
    end

    it "accepts a private integration token" do
      expect { described_class.new(private_integration_token: "pit") }.not_to raise_error
    end

    it "accepts a client_id + client_secret pair" do
      expect { described_class.new(client_id: "id", client_secret: "secret") }.not_to raise_error
    end

    it "rejects a lone client_id without a client_secret" do
      expect { described_class.new(client_id: "id") }.to raise_error(HighLevel::ConfigurationError)
    end

    it "accepts a pre-built Configuration instance" do
      config = HighLevel::Configuration.new(private_integration_token: "pit")
      expect { described_class.new(config) }.not_to raise_error
    end
  end

  describe "#connection" do
    let(:client) { described_class.new(private_integration_token: "pit-xyz") }

    it "round-trips GET /health with auth + version headers and a parsed body" do
      stub_request(:get, "https://services.leadconnectorhq.com/health")
        .with(headers: { "Authorization" => "Bearer pit-xyz", "Version" => "2021-07-28" })
        .to_return(
          status: 200,
          body: '{"ok":true}',
          headers: { "Content-Type" => "application/json" }
        )

      response = client.connection.get("/health")

      expect(response.status).to eq(200)
      expect(response.body).to eq({ "ok" => true })
    end

    it "raises UnauthorizedError on a 401 response" do
      stub_request(:get, "https://services.leadconnectorhq.com/health")
        .to_return(
          status: 401,
          body: '{"err":"nope"}',
          headers: { "Content-Type" => "application/json", "x-request-id" => "req-42" }
        )

      expect { client.connection.get("/health") }.to raise_error(HighLevel::UnauthorizedError) do |e|
        expect(e.status).to eq(401)
        expect(e.request_id).to eq("req-42")
      end
    end
  end
end
