# frozen_string_literal: true

require "spec_helper"
require "json"

fixture_path = File.expand_path("../fixtures/token_resolution.json", __dir__)
fixtures = JSON.parse(File.read(fixture_path))

RSpec.describe HighLevel::TokenResolver do
  def symbolize_preference(value)
    return nil if value.nil?

    value.to_sym
  end

  def build_config(hash)
    HighLevel::Configuration.new(**(hash || {}).transform_keys(&:to_sym))
  end

  def call_resolver(resolver, args)
    resolver.resolve(
      security_requirements: args["security_requirements"] || [],
      headers: args["headers"] || {},
      query: args["query"] || {},
      body: args["body"] || {},
      preference: symbolize_preference(args["preference"])
    )
  end

  describe "#resolve" do
    fixtures.fetch("resolve").each do |fixture|
      it fixture.fetch("name") do
        resolver = described_class.new(config: build_config(fixture["config"]))
        expected = fixture.fetch("expect")

        if expected["error"]
          error_class = HighLevel.const_get(expected["error"])
          expect { call_resolver(resolver, fixture.fetch("args")) }.to raise_error(error_class) do |e|
            expect(e.message).to include(expected["message_includes"]) if expected["message_includes"]
          end
        else
          result = call_resolver(resolver, fixture.fetch("args"))
          expect(result.token).to eq(expected.fetch("token"))
          expect(result.source).to eq(expected.fetch("source").to_sym)
        end
      end
    end
  end

  describe "#extract_resource_id" do
    let(:resolver) do
      described_class.new(config: HighLevel::Configuration.new(private_integration_token: "irrelevant"))
    end

    fixtures.fetch("extract_resource_id").each do |fixture|
      it fixture.fetch("name") do
        args = fixture.fetch("args")
        result = resolver.extract_resource_id(
          security_requirements: args["security_requirements"] || [],
          headers: args["headers"] || {},
          query: args["query"] || {},
          body: args["body"] || {},
          preference: symbolize_preference(args["preference"])
        )

        expect(result).to eq(fixture.fetch("expect"))
      end
    end
  end

  describe "storage fallback" do
    let(:config) { HighLevel::Configuration.new }

    it "uses the storage token when no direct token is configured" do
      storage = double("Storage") # rubocop:disable RSpec/VerifiedDoubles
      allow(storage).to receive(:get_session).with("loc-1")
                                             .and_return({ access_token: "stored-loc" })
      resolver = described_class.new(config: config, storage: storage)

      result = resolver.resolve(
        security_requirements: ["Location-Access-Only"],
        headers: { "x-location-id" => "loc-1" }
      )

      expect(result.token).to eq("stored-loc")
      expect(result.source).to eq(:storage)
    end

    it "returns the storage token under string keys too" do
      storage = double("Storage") # rubocop:disable RSpec/VerifiedDoubles
      allow(storage).to receive(:get_session).with("co-1")
                                             .and_return({ "access_token" => "stored-co" })
      resolver = described_class.new(config: config, storage: storage)

      result = resolver.resolve(
        security_requirements: ["Agency-Access-Only"],
        headers: { "x-company-id" => "co-1" }
      )

      expect(result.token).to eq("stored-co")
    end

    it "raises when storage returns nil and no direct token exists" do
      storage = double("Storage") # rubocop:disable RSpec/VerifiedDoubles
      allow(storage).to receive(:get_session).and_return(nil)
      resolver = described_class.new(config: config, storage: storage)

      expect do
        resolver.resolve(
          security_requirements: ["Location-Access-Only"],
          headers: { "x-location-id" => "loc-1" }
        )
      end.to raise_error(HighLevel::ConfigurationError)
    end
  end
end
