# frozen_string_literal: true

require "test_helper"

module HighLevel
  class OauthTest < Minitest::Test
    BASE = "https://services.leadconnectorhq.com"

    def config(**overrides)
      Configuration.new(
        client_id: "test-client-id",
        client_secret: "test-client-secret",
        redirect_uri: "https://example.com/cb",
        **overrides
      )
    end

    def oauth(**overrides)
      Oauth.new(config: config(**overrides))
    end

    def stub_oauth_token(response_body: { access_token: "new-tok", refresh_token: "new-ref" })
      stub_request(:post, "#{BASE}/oauth/token")
        .to_return(
          status: 200,
          body: JSON.generate(response_body),
          headers: { "Content-Type" => "application/json" }
        )
    end

    def test_authorization_url_builds_marketplace_url
      url = oauth.authorization_url(scope: "contacts.readonly contacts.write")

      assert_includes url, "https://marketplace.gohighlevel.com/oauth/chooselocation?"
      assert_includes url, "client_id=test-client-id"
      assert_includes url, "redirect_uri=https%3A%2F%2Fexample.com%2Fcb"
      assert_includes url, "scope=contacts.readonly+contacts.write"
      assert_includes url, "response_type=code"
    end

    def test_authorization_url_accepts_explicit_redirect_uri_override
      url = oauth.authorization_url(scope: "contacts.readonly", redirect_uri: "https://other.example/cb")
      assert_includes url, "redirect_uri=https%3A%2F%2Fother.example%2Fcb"
    end

    def test_authorization_url_requires_client_id
      assert_raises(ConfigurationError) do
        Oauth.new(config: Configuration.new(redirect_uri: "https://x")).authorization_url(scope: "x")
      end
    end

    def test_refresh_token_posts_form_encoded_body
      stub_oauth_token

      oauth.refresh_token(refresh_token: "ref-1", user_type: "Location")

      assert_requested(:post, "#{BASE}/oauth/token") do |req|
        body_params = URI.decode_www_form(req.body).to_h
        req.headers["Content-Type"].start_with?("application/x-www-form-urlencoded") &&
          body_params == {
            "grant_type" => "refresh_token",
            "refresh_token" => "ref-1",
            "client_id" => "test-client-id",
            "client_secret" => "test-client-secret",
            "user_type" => "Location"
          }
      end
    end

    def test_refresh_token_rejects_invalid_user_type
      assert_raises(ArgumentError) do
        oauth.refresh_token(refresh_token: "x", user_type: "Bogus")
      end
    end

    def test_exchange_code_posts_with_authorization_code_grant
      stub_oauth_token

      oauth.exchange_code(code: "auth-code-123", user_type: "Location")

      assert_requested(:post, "#{BASE}/oauth/token") do |req|
        body_params = URI.decode_www_form(req.body).to_h
        body_params["grant_type"] == "authorization_code" &&
          body_params["code"] == "auth-code-123" &&
          body_params["redirect_uri"] == "https://example.com/cb"
      end
    end

    def test_exchange_code_returns_parsed_body
      stub_oauth_token(response_body: { access_token: "tok", scope: "contacts.readonly" })

      result = oauth.exchange_code(code: "code", user_type: "Location")

      assert_equal "tok", result["access_token"]
      assert_equal "contacts.readonly", result["scope"]
    end

    def test_get_location_access_token_posts_with_agency_bearer
      stub_request(:post, "#{BASE}/oauth/locationToken")
        .to_return(
          status: 200,
          body: '{"access_token":"loc-tok"}',
          headers: { "Content-Type" => "application/json" }
        )

      result = oauth(agency_access_token: "agency-xyz")
               .get_location_access_token(company_id: "co-1", location_id: "loc-1")

      assert_equal "loc-tok", result["access_token"]
      assert_requested(:post, "#{BASE}/oauth/locationToken") do |req|
        body_params = URI.decode_www_form(req.body).to_h
        req.headers["Authorization"] == "Bearer agency-xyz" &&
          body_params == { "companyId" => "co-1", "locationId" => "loc-1" }
      end
    end

    def test_get_location_access_token_uses_explicit_authorization_token
      stub_request(:post, "#{BASE}/oauth/locationToken")
        .to_return(status: 200, body: "{}", headers: { "Content-Type" => "application/json" })

      Oauth.new(config: Configuration.new(client_id: "x", client_secret: "y"))
           .get_location_access_token(company_id: "co", location_id: "loc", authorization_token: "from-fallback")

      assert_requested(:post, "#{BASE}/oauth/locationToken",
                       headers: { "Authorization" => "Bearer from-fallback" })
    end

    def test_get_location_access_token_raises_without_agency_token
      assert_raises(ConfigurationError) do
        Oauth.new(config: Configuration.new(client_id: "x", client_secret: "y"))
             .get_location_access_token(company_id: "co", location_id: "loc")
      end
    end

    def test_raises_typed_error_on_oauth_endpoint_failure
      stub_request(:post, "#{BASE}/oauth/token")
        .to_return(status: 401, body: '{"err":"bad"}', headers: { "Content-Type" => "application/json" })

      assert_raises(UnauthorizedError) do
        oauth.refresh_token(refresh_token: "x", user_type: "Location")
      end
    end
  end
end
