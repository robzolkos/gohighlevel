# frozen_string_literal: true

module HighLevel
  # OAuth 2.0 client for the HighLevel API.
  #
  # Source of truth: https://marketplace.gohighlevel.com/docs/ghl/oauth/
  #
  # All HTTP methods POST application/x-www-form-urlencoded bodies; this
  # class owns its own Faraday connection rather than reusing the main
  # client's (which is JSON-encoded).
  class Oauth
    # Base URL for the marketplace authorization page.
    MARKETPLACE_URL = "https://marketplace.gohighlevel.com"
    # The accepted +user_type+ values for the token endpoints.
    USER_TYPES = %w[Location Company].freeze

    def initialize(config:)
      @config = config
    end

    # Build the URL the end user is redirected to in order to grant the app
    # access. Pure URL construction; no HTTP.
    def authorization_url(scope:, redirect_uri: nil)
      params = URI.encode_www_form(
        client_id: require_value!(:client_id),
        redirect_uri: redirect_uri || require_value!(:redirect_uri),
        scope: scope,
        response_type: "code"
      )
      "#{MARKETPLACE_URL}/oauth/chooselocation?#{params}"
    end

    # Exchange an authorization code for an access + refresh token pair.
    def exchange_code(code:, user_type:, redirect_uri: nil)
      assert_user_type!(user_type)
      post_form("/oauth/token", body: {
        grant_type: "authorization_code",
        code: code,
        client_id: require_value!(:client_id),
        client_secret: require_value!(:client_secret),
        user_type: user_type,
        redirect_uri: redirect_uri || @config.redirect_uri
      }.compact)
    end

    # Refresh an access token using its refresh token.
    def refresh_token(refresh_token:, user_type:)
      assert_user_type!(user_type)
      post_form("/oauth/token", body: {
                  grant_type: "refresh_token",
                  refresh_token: refresh_token,
                  client_id: require_value!(:client_id),
                  client_secret: require_value!(:client_secret),
                  user_type: user_type
                })
    end

    # Derive a location-scoped access token from an agency token.
    # The agency token is taken from `config.agency_access_token` unless
    # `authorization_token:` is explicitly supplied (used by the
    # company-token fallback flow).
    def get_location_access_token(company_id:, location_id:, authorization_token: nil)
      bearer = authorization_token || @config.agency_access_token
      raise ConfigurationError, "agency access token required for get_location_access_token" if bearer.nil?

      post_form(
        "/oauth/locationToken",
        body: { companyId: company_id, locationId: location_id },
        authorization: "Bearer #{bearer}"
      )
    end

    private

    def assert_user_type!(user_type)
      return if USER_TYPES.include?(user_type.to_s)

      raise ArgumentError, "user_type must be one of: #{USER_TYPES.join(", ")}"
    end

    def require_value!(field)
      value = @config.public_send(field)
      raise ConfigurationError, "#{field} is required for this OAuth flow" if value.nil? || value.to_s.empty?

      value
    end

    def post_form(path, body:, authorization: nil)
      response = connection.post(path) do |req|
        req.headers["Content-Type"] = "application/x-www-form-urlencoded"
        req.headers["Version"] = @config.api_version
        req.headers["Authorization"] = authorization if authorization
        req.body = URI.encode_www_form(body)
      end
      response.body
    end

    def connection
      @connection ||= Faraday.new(url: @config.base_url) do |f|
        f.use Middleware::ErrorHandler
        f.response :json, content_type: /\bjson\b/
        f.adapter Faraday.default_adapter
      end
    end
  end
end
