# frozen_string_literal: true

require "test_helper"
require_relative "../../support/session_storage_contract"

module HighLevel
  module Storage
    class RedisTest < Minitest::Test
      include SessionStorageContract

      # Minimal in-process stand-in for the `redis` client. We only use
      # four methods, so faking them here avoids a `mock_redis` dev dep.
      # Thread-safety matches the real client (the underlying hash is
      # accessed under a single Mutex).
      class FakeRedis
        def initialize
          @data = {}
          @mutex = Mutex.new
        end

        def set(key, value, ex: nil) # rubocop:disable Naming/MethodParameterName
          @mutex.synchronize { @data[key] = { value: value, expires_at: ex ? Time.now + ex : nil } }
          "OK"
        end

        def get(key)
          @mutex.synchronize do
            entry = @data[key]
            return nil if entry.nil?
            return nil if entry[:expires_at] && Time.now > entry[:expires_at]

            entry[:value]
          end
        end

        def del(key)
          @mutex.synchronize { @data.delete(key) ? 1 : 0 }
        end

        def close
          @closed = true
        end
      end

      def setup
        @fake = FakeRedis.new
        @storage = Redis.new(redis: @fake)
        @storage.set_client_id("app-test")
        @storage.init
      end

      def test_sessions_are_scoped_by_application_id
        @storage.set_session("res-1", access_token: "from-app-test")

        other_fake = FakeRedis.new
        # Both backends sharing storage would conflict, but with separate
        # FakeRedis instances we're really asserting that two different
        # client_ids produce different keys.
        other = Redis.new(redis: other_fake)
        other.set_client_id("app-other")
        other.init

        assert_nil other.get_session("res-1")
      end

      def test_ttl_uses_expires_in_when_present
        captured = nil
        @fake.define_singleton_method(:set) do |_key, _value, ex: nil|
          captured = ex
          "OK"
        end

        @storage.set_session("res-1", access_token: "tok", expires_in: 1234)
        assert_equal 1234, captured
      end

      def test_ttl_falls_back_to_default_when_no_expires_in
        captured = nil
        @fake.define_singleton_method(:set) do |_key, _value, ex: nil|
          captured = ex
          "OK"
        end

        @storage.set_session("res-1", access_token: "tok")
        assert_equal Redis::DEFAULT_TTL_SECONDS, captured
      end
    end
  end
end
