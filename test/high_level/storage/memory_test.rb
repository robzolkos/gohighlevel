# frozen_string_literal: true

require "test_helper"
require_relative "../../support/session_storage_contract"

module HighLevel
  module Storage
    class MemoryTest < Minitest::Test
      include SessionStorageContract

      def setup
        @storage = Memory.new
        @storage.set_client_id("app-test")
        @storage.init
      end

      def test_disconnect_clears_sessions
        @storage.set_session("res-1", access_token: "tok-1")
        @storage.disconnect

        assert_nil @storage.get_session("res-1")
      end

      def test_sessions_are_scoped_by_application_id
        @storage.set_session("res-1", access_token: "from-app-test")

        other = Memory.new
        other.set_client_id("app-other")
        other.init

        assert_nil other.get_session("res-1")
      end

      def test_works_without_client_id_using_default_namespace
        unbranded = Memory.new
        unbranded.init
        unbranded.set_session("res-1", access_token: "tok-1")

        assert_equal "tok-1", unbranded.get_access_token("res-1")
      end

      def test_storage_active_reports_initialization_state
        fresh = Memory.new
        refute_predicate fresh, :storage_active?

        fresh.init
        assert_predicate fresh, :storage_active?

        fresh.disconnect
        refute_predicate fresh, :storage_active?
      end

      def test_session_count_tracks_writes
        @storage.set_session("a", access_token: "1")
        @storage.set_session("b", access_token: "2")

        assert_equal 2, @storage.session_count
      end

      def test_accepts_string_keys_in_session_data
        @storage.set_session("res-1", "access_token" => "tok-1", "refresh_token" => "ref-1")
        session = @storage.get_session("res-1")

        assert_equal "tok-1", session[:access_token]
        assert_equal "tok-1", @storage.get_access_token("res-1")
      end
    end

    class BaseTest < Minitest::Test
      def test_abstract_methods_raise_not_implemented
        base = Base.new

        assert_raises(NotImplementedError) { base.init }
        assert_raises(NotImplementedError) { base.disconnect }
        assert_raises(NotImplementedError) { base.set_client_id("x") }
        assert_raises(NotImplementedError) { base.get_session("x") }
        assert_raises(NotImplementedError) { base.set_session("x", {}) }
        assert_raises(NotImplementedError) { base.get_access_token("x") }
        assert_raises(NotImplementedError) { base.delete_session("x") }
      end
    end
  end
end
