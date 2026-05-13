# frozen_string_literal: true

require "test_helper"

module HighLevel
  class ClientTest < Minitest::Test
    def test_raises_without_credentials
      assert_raises(ConfigurationError) { Client.new }
    end

    def test_accepts_private_integration_token
      Client.new(private_integration_token: "pit")
    end

    def test_accepts_client_id_and_secret
      Client.new(client_id: "id", client_secret: "secret")
    end

    def test_rejects_lone_client_id
      assert_raises(ConfigurationError) { Client.new(client_id: "id") }
    end

    def test_accepts_prebuilt_configuration
      config = Configuration.new(private_integration_token: "pit")
      Client.new(config)
    end

    def test_round_trips_get_health_with_auth_and_version_headers
      stub_request(:get, "https://services.leadconnectorhq.com/health")
        .with(headers: { "Authorization" => "Bearer pit-xyz", "Version" => "2021-07-28" })
        .to_return(
          status: 200,
          body: '{"ok":true}',
          headers: { "Content-Type" => "application/json" }
        )

      client = Client.new(private_integration_token: "pit-xyz")
      response = client.connection.get("/health")

      assert_equal 200, response.status
      assert_equal({ "ok" => true }, response.body)
    end

    def test_raises_unauthorized_on_unauthorized_response
      stub_request(:get, "https://services.leadconnectorhq.com/health")
        .to_return(
          status: 401,
          body: '{"err":"nope"}',
          headers: { "Content-Type" => "application/json", "x-request-id" => "req-42" }
        )

      client = Client.new(private_integration_token: "pit-xyz")
      error = assert_raises(UnauthorizedError) { client.connection.get("/health") }

      assert_equal 401, error.status
      assert_equal "req-42", error.request_id
    end
  end
end
