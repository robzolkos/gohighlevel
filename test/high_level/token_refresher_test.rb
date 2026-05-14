# frozen_string_literal: true

require "test_helper"

module HighLevel
  class TokenRefresherTest < Minitest::Test
    class FakeOauth
      attr_reader :refresh_calls, :location_token_calls

      def initialize(behaviors: {})
        @behaviors = behaviors
        @refresh_calls = []
        @location_token_calls = []
      end

      def refresh_token(refresh_token:, user_type:)
        @refresh_calls << { refresh_token: refresh_token, user_type: user_type }
        invoke(:refresh, user_type)
      end

      def get_location_access_token(company_id:, location_id:, authorization_token: nil)
        @location_token_calls << {
          company_id: company_id,
          location_id: location_id,
          authorization_token: authorization_token
        }
        invoke(:location_token, nil)
      end

      private

      def invoke(key, sub)
        behavior = @behaviors[sub ? :"#{key}_#{sub}" : key] || @behaviors[key]
        raise behavior if behavior.is_a?(HighLevel::Error)
        return behavior.call if behavior.is_a?(Proc)

        behavior || raise(ArgumentError, "no behavior configured for #{key}/#{sub}")
      end
    end

    def setup
      @storage = Storage::Memory.new
      @storage.init
      @config = Configuration.new(
        client_id: "test-cid",
        client_secret: "test-secret",
        session_storage: @storage
      )
    end

    def make_refresher(behaviors: {})
      TokenRefresher.new(config: @config, oauth: FakeOauth.new(behaviors: behaviors), storage: @storage)
    end

    def test_returns_nil_when_no_session_exists
      refresher = make_refresher
      assert_nil refresher.refresh_for(resource_id: "loc-1")
    end

    def test_returns_nil_when_session_has_no_refresh_token
      @storage.set_session("loc-1", access_token: "expired")
      assert_nil make_refresher.refresh_for(resource_id: "loc-1")
    end

    def test_refreshes_a_location_session_happy_path
      @storage.set_session("loc-1",
                           refresh_token: "ref-1",
                           userType: "Location",
                           access_token: "old")
      refresher = make_refresher(
        behaviors: { refresh: { access_token: "new-loc", refresh_token: "new-ref" } }
      )

      new_token = refresher.refresh_for(resource_id: "loc-1")

      assert_equal "new-loc", new_token
      assert_equal "new-loc", @storage.get_access_token("loc-1")
    end

    def test_falls_back_to_company_token_when_location_refresh_fails
      @storage.set_session("loc-1",
                           refresh_token: "loc-ref",
                           userType: "Location",
                           companyId: "co-1")
      # Company token is valid (not expired) — fallback uses it directly.
      @storage.set_session("co-1",
                           access_token: "company-tok",
                           userType: "Company")
      override_company_expiry("co-1", :far_future)

      refresher = make_refresher(behaviors: {
                                   refresh: UnauthorizedError.new("loc refresh failed", status: 401),
                                   location_token: { access_token: "derived-loc" }
                                 })

      new_token = refresher.refresh_for(resource_id: "loc-1")

      assert_equal "derived-loc", new_token
      assert_equal "derived-loc", @storage.get_access_token("loc-1")
      assert_equal "co-1", @storage.get_session("loc-1")[:companyId]
    end

    def test_does_not_fall_back_for_company_sessions
      @storage.set_session("co-1",
                           refresh_token: "co-ref",
                           userType: "Company")
      refresher = make_refresher(
        behaviors: { refresh: UnauthorizedError.new("nope", status: 401) }
      )

      assert_nil refresher.refresh_for(resource_id: "co-1")
    end

    def test_refreshes_expired_company_token_before_using_it_in_fallback
      @storage.set_session("loc-1",
                           refresh_token: "loc-ref",
                           userType: "Location",
                           companyId: "co-1")
      @storage.set_session("co-1",
                           access_token: "expired-co",
                           refresh_token: "co-ref",
                           userType: "Company")
      override_company_expiry("co-1", :past)

      refresher = make_refresher(behaviors: {
                                   refresh_Location: UnauthorizedError.new("loc refresh failed", status: 401),
                                   refresh_Company: { access_token: "fresh-co" },
                                   location_token: { access_token: "derived-loc" }
                                 })

      assert_equal "derived-loc", refresher.refresh_for(resource_id: "loc-1")
      assert_equal "fresh-co", @storage.get_access_token("co-1")
    end

    def test_returns_nil_when_company_session_missing_for_fallback
      @storage.set_session("loc-1",
                           refresh_token: "loc-ref",
                           userType: "Location",
                           companyId: "missing-co")

      refresher = make_refresher(
        behaviors: { refresh: UnauthorizedError.new("nope", status: 401) }
      )

      assert_nil refresher.refresh_for(resource_id: "loc-1")
    end

    def test_returns_nil_when_location_token_derivation_itself_fails
      @storage.set_session("loc-1",
                           refresh_token: "loc-ref",
                           userType: "Location",
                           companyId: "co-1")
      @storage.set_session("co-1", access_token: "company-tok", userType: "Company")
      override_company_expiry("co-1", :far_future)

      refresher = make_refresher(behaviors: {
                                   refresh: UnauthorizedError.new("loc refresh failed", status: 401),
                                   location_token: ServerError.new("locationToken endpoint down", status: 500)
                                 })

      assert_nil refresher.refresh_for(resource_id: "loc-1")
    end

    def test_returns_nil_when_company_token_refresh_fails_during_fallback
      @storage.set_session("loc-1",
                           refresh_token: "loc-ref",
                           userType: "Location",
                           companyId: "co-1")
      @storage.set_session("co-1",
                           access_token: "expired-co",
                           refresh_token: "co-ref",
                           userType: "Company")
      override_company_expiry("co-1", :past)

      refresher = make_refresher(behaviors: {
                                   refresh_Location: UnauthorizedError.new("loc refresh failed", status: 401),
                                   refresh_Company: UnauthorizedError.new("co refresh failed", status: 401)
                                 })

      assert_nil refresher.refresh_for(resource_id: "loc-1")
    end

    private

    # Reach into Memory's private store to set expire_at. Memory's set_session
    # always stamps expire_at = now+1d (or expires_in), so to simulate an
    # expired company token we patch it directly.
    def override_company_expiry(resource_id, mode)
      sessions = @storage.instance_variable_get(:@sessions)
      key = sessions.keys.find { |k| k.end_with?(":#{resource_id}") }
      now_ms = (Time.now.to_f * 1000).to_i
      sessions[key][:expire_at] = mode == :past ? now_ms - 1000 : now_ms + 86_400_000
    end
  end
end
