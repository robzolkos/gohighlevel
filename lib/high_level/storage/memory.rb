# frozen_string_literal: true

require "monitor"

module HighLevel
  module Storage
    # Thread-safe in-memory SessionStorage. Default storage when no other
    # backend is configured. Ported from
    # vendor/highlevel-api-sdk/lib/storage/memory-session-storage.ts; uses a
    # Monitor instead of JS's single-threaded model.
    class Memory < Base
      TIMESTAMP_KEYS = %i[created_at updated_at].freeze

      def initialize
        super
        @monitor = Monitor.new
        @sessions = {}
        @client_id = nil
        @initialized = false
      end

      def init
        @monitor.synchronize { @initialized = true }
      end

      def disconnect
        @monitor.synchronize do
          @sessions.clear
          @initialized = false
        end
      end

      def set_client_id(client_id)
        raise ArgumentError, "client_id is required" if client_id.nil? || client_id.to_s.empty?

        @monitor.synchronize { @client_id = client_id.to_s }
      end

      def set_session(resource_id, session_data)
        data = symbolize_keys(session_data)
        document = data.merge(
          expire_at: calculate_expire_at(data[:expires_in]),
          created_at: Time.now,
          updated_at: Time.now
        )
        @monitor.synchronize { @sessions[unique_key(resource_id)] = document }
        nil
      end

      def get_session(resource_id)
        @monitor.synchronize do
          document = @sessions[unique_key(resource_id)]
          return nil if document.nil?

          document.except(*TIMESTAMP_KEYS)
        end
      end

      def get_access_token(resource_id)
        session = get_session(resource_id)
        session && session[:access_token]
      end

      def delete_session(resource_id)
        @monitor.synchronize { @sessions.delete(unique_key(resource_id)) }
        nil
      end

      def session_count
        @monitor.synchronize { @sessions.size }
      end

      def storage_active?
        @monitor.synchronize { @initialized }
      end

      private

      def unique_key(resource_id)
        "#{application_id}:#{resource_id}"
      end

      def application_id
        return "default" if @client_id.nil? || @client_id.empty?

        @client_id.split("-").first
      end

      def symbolize_keys(hash)
        return {} if hash.nil?

        hash.transform_keys(&:to_sym)
      end
    end
  end
end
