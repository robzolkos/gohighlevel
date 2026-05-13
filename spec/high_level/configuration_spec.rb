# frozen_string_literal: true

require "spec_helper"

RSpec.describe HighLevel::Configuration do
  it "defaults api_version to the documented version" do
    expect(described_class.new.api_version).to eq("2021-07-28")
  end

  it "defaults base_url to the leadconnectorhq host" do
    expect(described_class.new.base_url).to eq("https://services.leadconnectorhq.com")
  end

  it "round-trips an explicit private_integration_token" do
    config = described_class.new(private_integration_token: "pit-xyz")
    expect(config.private_integration_token).to eq("pit-xyz")
  end

  it "is immutable (no setters)" do
    config = described_class.new(private_integration_token: "pit-xyz")
    expect { config.private_integration_token = "other" }.to raise_error(NoMethodError)
  end

  it "supports value equality across instances with identical attributes" do
    a = described_class.new(private_integration_token: "x")
    b = described_class.new(private_integration_token: "x")
    expect(a).to eq(b)
  end

  it "leaves credential fields nil when not provided" do
    config = described_class.new
    expect(config.private_integration_token).to be_nil
    expect(config.agency_access_token).to be_nil
    expect(config.location_access_token).to be_nil
    expect(config.client_id).to be_nil
    expect(config.client_secret).to be_nil
  end
end
