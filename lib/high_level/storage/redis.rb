# frozen_string_literal: true

require "redis"
require "json"
require "time"

module HighLevel
  module Storage
    # Redis-backed session storage. Good for multi-process worker setups
    # where Memory is per-process. Keys are prefixed with `gohighlevel:`
    # and namespaced by the application_id derived from `client_id`.
    # Each session is JSON-encoded and given a TTL equal to its
    # `expires_in` (falling back to one day) so expired sessions are
    # cleaned up by Redis itself.
    class Redis < Base
      # Session TTL, in seconds, when an OAuth response has no +expires_in+.
      DEFAULT_TTL_SECONDS = 24 * 60 * 60
      # Key prefix for every session entry.
      KEY_PREFIX = "gohighlevel"

      # @param redis [::Redis, nil] an existing client, or nil to build one
      # @param ttl [Integer] fallback TTL in seconds
      # @param redis_options [Hash] options forwarded to +::Redis.new+
      def initialize(redis: nil, ttl: DEFAULT_TTL_SECONDS, **redis_options)
        super()
        @redis = redis || ::Redis.new(**redis_options)
        @default_ttl = ttl
        @client_id = nil
      end

      # (see Base#init)
      def init
        # No-op — connection is lazy on the Redis client.
      end

      # (see Base#disconnect)
      def disconnect
        @redis.close
      end

      # (see Base#set_client_id)
      def set_client_id(client_id)
        raise ArgumentError, "client_id is required" if client_id.nil? || client_id.to_s.empty?

        @client_id = client_id.to_s
      end

      # (see Base#set_session)
      def set_session(resource_id, session_data)
        data = symbolize_keys(session_data)
        document = data.merge(expire_at: calculate_expire_at(data[:expires_in]))
        @redis.set(key_for(resource_id), JSON.generate(document), ex: ttl_for(data))
        nil
      end

      # (see Base#get_session)
      def get_session(resource_id)
        raw = @redis.get(key_for(resource_id))
        return nil if raw.nil?

        JSON.parse(raw, symbolize_names: true)
      end

      # (see Base#get_access_token)
      def get_access_token(resource_id)
        session = get_session(resource_id)
        session && session[:access_token]
      end

      # (see Base#delete_session)
      def delete_session(resource_id)
        @redis.del(key_for(resource_id))
        nil
      end

      private

      def key_for(resource_id)
        "#{KEY_PREFIX}:#{application_id}:#{resource_id}"
      end

      def application_id
        return "default" if @client_id.nil? || @client_id.empty?

        @client_id.split("-").first
      end

      def ttl_for(session)
        ttl = session[:expires_in]
        Integer(ttl.nil? ? @default_ttl : ttl)
      end

      def symbolize_keys(hash)
        return {} if hash.nil?

        hash.transform_keys(&:to_sym)
      end
    end
  end
end
