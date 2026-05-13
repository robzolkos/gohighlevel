# frozen_string_literal: true

module HighLevel
  module Storage
    # Abstract base for session storage backends. Subclasses must implement
    # the seven session operations; the base only provides the shared
    # expire-at calculation. Ported from
    # vendor/highlevel-api-sdk/lib/storage/session-storage.ts.
    class Base
      DEFAULT_EXPIRY_MS = 24 * 60 * 60 * 1000

      def init
        raise NotImplementedError, "#{self.class}#init must be implemented"
      end

      def disconnect
        raise NotImplementedError, "#{self.class}#disconnect must be implemented"
      end

      def set_client_id(_client_id)
        raise NotImplementedError, "#{self.class}#set_client_id must be implemented"
      end

      def get_session(_resource_id)
        raise NotImplementedError, "#{self.class}#get_session must be implemented"
      end

      def set_session(_resource_id, _session_data)
        raise NotImplementedError, "#{self.class}#set_session must be implemented"
      end

      def get_access_token(_resource_id)
        raise NotImplementedError, "#{self.class}#get_access_token must be implemented"
      end

      def delete_session(_resource_id)
        raise NotImplementedError, "#{self.class}#delete_session must be implemented"
      end

      protected

      def calculate_expire_at(expires_in)
        now_ms = (Time.now.to_f * 1000).to_i
        return now_ms + DEFAULT_EXPIRY_MS if expires_in.nil?

        now_ms + (Integer(expires_in) * 1000)
      end
    end
  end
end
