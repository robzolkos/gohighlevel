# frozen_string_literal: true

require "test_helper"

module HighLevel
  module Middleware
    class RefreshOn401Test < Minitest::Test
      BASE = "https://services.leadconnectorhq.com"

      def setup
        @storage = Storage::Memory.new
        @storage.init
        @config = Configuration.new(
          client_id: "test-cid",
          client_secret: "test-secret",
          session_storage: @storage
        )
        @client = Client.new(@config)
      end

      def with_security_context(security:)
        ->(req) { req.options.context = { Authentication::CONTEXT_KEY => security } }
      end

      def test_401_triggers_refresh_and_retry_succeeds
        @storage.set_session("loc-1",
                             access_token: "old-tok",
                             refresh_token: "ref-1",
                             userType: "Location")

        # First call returns 401 (with old token), second call returns 200 (with new token).
        stub_request(:get, "#{BASE}/contacts/abc")
          .with(headers: { "Authorization" => "Bearer old-tok" })
          .to_return(status: 401, body: "{}", headers: { "Content-Type" => "application/json" })
        stub_request(:get, "#{BASE}/contacts/abc")
          .with(headers: { "Authorization" => "Bearer new-tok" })
          .to_return(status: 200, body: '{"ok":true}', headers: { "Content-Type" => "application/json" })

        # Refresh endpoint hands out new-tok.
        stub_request(:post, "#{BASE}/oauth/token")
          .to_return(
            status: 200,
            body: '{"access_token":"new-tok","refresh_token":"new-ref"}',
            headers: { "Content-Type" => "application/json" }
          )

        ctx = with_security_context(security: { security_requirements: ["Location-Access-Only"] })
        response = @client.connection.get("/contacts/abc", nil, { "x-location-id" => "loc-1" }, &ctx)

        assert_equal 200, response.status
        assert_equal({ "ok" => true }, response.body)
        assert_equal "new-tok", @storage.get_access_token("loc-1")
      end

      def test_401_with_location_refresh_failure_falls_back_to_company_token
        @storage.set_session("loc-1",
                             access_token: "old-loc",
                             refresh_token: "bad-ref",
                             userType: "Location",
                             companyId: "co-1")
        @storage.set_session("co-1",
                             access_token: "company-tok",
                             userType: "Company")
        override_expiry("co-1", :far_future)

        # API: 401 then 200
        stub_request(:get, "#{BASE}/contacts/abc")
          .with(headers: { "Authorization" => "Bearer old-loc" })
          .to_return(status: 401, body: "{}", headers: { "Content-Type" => "application/json" })
        stub_request(:get, "#{BASE}/contacts/abc")
          .with(headers: { "Authorization" => "Bearer derived-loc" })
          .to_return(status: 200, body: '{"ok":true}', headers: { "Content-Type" => "application/json" })

        # Location refresh fails (refresh_token is bad).
        stub_request(:post, "#{BASE}/oauth/token")
          .to_return(status: 401, body: '{"err":"bad refresh"}',
                     headers: { "Content-Type" => "application/json" })

        # Company-token fallback successfully derives a new location token.
        stub_request(:post, "#{BASE}/oauth/locationToken")
          .with(headers: { "Authorization" => "Bearer company-tok" })
          .to_return(status: 200, body: '{"access_token":"derived-loc"}',
                     headers: { "Content-Type" => "application/json" })

        ctx = with_security_context(security: { security_requirements: ["Location-Access-Only"] })
        response = @client.connection.get("/contacts/abc", nil, { "x-location-id" => "loc-1" }, &ctx)

        assert_equal 200, response.status
        assert_equal "derived-loc", @storage.get_access_token("loc-1")
      end

      def test_401_with_no_resolvable_resource_id_propagates_unchanged
        stub_request(:get, "#{BASE}/contacts/abc")
          .to_return(status: 401, body: "{}", headers: { "Content-Type" => "application/json" })

        # No security context attached, no location/company id in headers.
        @config = Configuration.new(
          client_id: "cid",
          client_secret: "secret",
          location_access_token: "loc-direct",
          session_storage: @storage
        )
        client = Client.new(@config)

        assert_raises(UnauthorizedError) { client.connection.get("/contacts/abc") }
      end

      def test_401_after_refresh_still_401_does_not_loop
        @storage.set_session("loc-1",
                             access_token: "old-tok",
                             refresh_token: "ref-1",
                             userType: "Location")

        # API always returns 401.
        stub_request(:get, "#{BASE}/contacts/abc")
          .to_return(status: 401, body: "{}", headers: { "Content-Type" => "application/json" })

        # Refresh succeeds, but the second attempt is still 401.
        stub_request(:post, "#{BASE}/oauth/token")
          .to_return(
            status: 200,
            body: '{"access_token":"new-tok","refresh_token":"new-ref"}',
            headers: { "Content-Type" => "application/json" }
          )

        ctx = with_security_context(security: { security_requirements: ["Location-Access-Only"] })
        assert_raises(UnauthorizedError) do
          @client.connection.get("/contacts/abc", nil, { "x-location-id" => "loc-1" }, &ctx)
        end

        # Exactly two API requests (initial + one retry), not infinite.
        assert_requested(:get, "#{BASE}/contacts/abc", times: 2)
      end

      private

      def override_expiry(resource_id, mode)
        sessions = @storage.instance_variable_get(:@sessions)
        key = sessions.keys.find { |k| k.end_with?(":#{resource_id}") }
        now_ms = (Time.now.to_f * 1000).to_i
        sessions[key][:expire_at] = mode == :past ? now_ms - 1000 : now_ms + 86_400_000
      end
    end
  end
end
