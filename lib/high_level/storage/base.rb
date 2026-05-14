# frozen_string_literal: true

module HighLevel
  # Namespace for the session storage backends — {Storage::Memory}
  # (default), {Storage::Redis}, {Storage::ActiveRecord},
  # {Storage::Mongo}, and any custom backend subclassing {Storage::Base}.
  module Storage
    # Abstract base for session storage backends. Subclasses must implement
    # the seven session operations; the base only provides the shared
    # expire-at calculation. Ported from
    # vendor/highlevel-api-sdk/lib/storage/session-storage.ts.
    class Base
      # Default session lifetime, in milliseconds, when an OAuth response
      # carries no +expires_in+.
      DEFAULT_EXPIRY_MS = 24 * 60 * 60 * 1000

      # (the abstract methods take named args purely for documentation;
      # they raise before using them)

      # Initialize the backend (open connections, ensure schema, ...).
      # @return [void]
      def init
        raise NotImplementedError, "#{self.class}#init must be implemented"
      end

      # Release any resources held by the backend.
      # @return [void]
      def disconnect
        raise NotImplementedError, "#{self.class}#disconnect must be implemented"
      end

      # Set the OAuth client id; its first hyphen-separated segment
      # becomes the application namespace for stored sessions.
      # @param client_id [String]
      # @return [void]
      def set_client_id(client_id)
        raise NotImplementedError, "#{self.class}#set_client_id must be implemented"
      end

      # Fetch a stored session.
      # @param resource_id [String] a company or location id
      # @return [Hash, nil] the session data, or nil when absent
      def get_session(resource_id)
        raise NotImplementedError, "#{self.class}#get_session must be implemented"
      end

      # Store (or replace) a session, stamping +:expire_at+.
      # @param resource_id [String] a company or location id
      # @param session_data [Hash] the session payload
      # @return [void]
      def set_session(resource_id, session_data)
        raise NotImplementedError, "#{self.class}#set_session must be implemented"
      end

      # Fetch just the access token from a stored session.
      # @param resource_id [String] a company or location id
      # @return [String, nil]
      def get_access_token(resource_id)
        raise NotImplementedError, "#{self.class}#get_access_token must be implemented"
      end

      # Remove a stored session.
      # @param resource_id [String] a company or location id
      # @return [void]
      def delete_session(resource_id)
        raise NotImplementedError, "#{self.class}#delete_session must be implemented"
      end

      protected

      # @param expires_in [Integer, nil] OAuth +expires_in+ in seconds
      # @return [Integer] the absolute expiry timestamp in milliseconds
      def calculate_expire_at(expires_in)
        now_ms = (Time.now.to_f * 1000).to_i
        return now_ms + DEFAULT_EXPIRY_MS if expires_in.nil?

        now_ms + (Integer(expires_in) * 1000)
      end
    end
  end
end
