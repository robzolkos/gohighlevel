# frozen_string_literal: true

module HighLevel
  # Encapsulates the 401-recovery policy: refresh the access token via the
  # session's refresh_token, or fall back to deriving a fresh location
  # token from the company's agency token. Behaviorally matches
  # vendor/highlevel-api-sdk/lib/HighLevel.ts (`fetchToken` +
  # `handleLocationTokenFallback`).
  class TokenRefresher
    # A token within this many milliseconds of expiry is treated as
    # already expired and refreshed proactively.
    EXPIRY_BUFFER_MS = 60_000

    def initialize(config:, oauth:, storage:)
      @config = config
      @oauth = oauth
      @storage = storage
    end

    # Returns the new access_token string, or nil when no recovery is
    # possible (no session, no refresh_token, refresh fails and no
    # fallback applies).
    def refresh_for(resource_id:)
      return nil if @storage.nil? || resource_id.nil? || resource_id.to_s.empty?

      session = @storage.get_session(resource_id)
      return nil if session.nil?

      direct_refresh(resource_id, session) || fallback(resource_id, session)
    end

    private

    def direct_refresh(resource_id, session)
      refresh = pluck(session, :refresh_token)
      return nil if refresh.nil?

      user_type = pluck(session, :userType, :user_type) || "Location"
      new_data = @oauth.refresh_token(refresh_token: refresh, user_type: user_type)
      persist(resource_id, session, new_data)
      pluck(new_data, :access_token)
    rescue HighLevel::Error
      nil
    end

    # rubocop:disable Metrics/MethodLength
    def fallback(location_id, location_session)
      return nil unless eligible_for_fallback?(location_session)

      company_id = pluck(location_session, :companyId, :company_id)
      company_session = @storage.get_session(company_id)
      return nil if company_session.nil?

      company_token = ensure_fresh_company_token(company_id, company_session)
      return nil if company_token.nil?

      new_loc_data = @oauth.get_location_access_token(
        company_id: company_id,
        location_id: location_id,
        authorization_token: company_token
      )
      persist(location_id, location_session, new_loc_data.merge(companyId: company_id))
      pluck(new_loc_data, :access_token)
    rescue HighLevel::Error
      nil
    end
    # rubocop:enable Metrics/MethodLength

    def eligible_for_fallback?(session)
      user_type = pluck(session, :userType, :user_type)
      company_id = pluck(session, :companyId, :company_id)
      user_type == "Location" && !company_id.nil?
    end

    def ensure_fresh_company_token(company_id, session)
      return pluck(session, :access_token) unless expired?(session)

      refresh = pluck(session, :refresh_token)
      return nil if refresh.nil?

      new_data = @oauth.refresh_token(refresh_token: refresh, user_type: "Company")
      persist(company_id, session, new_data)
      pluck(new_data, :access_token)
    rescue HighLevel::Error
      nil
    end

    def expired?(session)
      expire_at = pluck(session, :expire_at)
      return true if expire_at.nil?

      ((Time.now.to_f * 1000).to_i + EXPIRY_BUFFER_MS) >= Integer(expire_at)
    end

    def persist(resource_id, original, updates)
      merged = symbolize(original).merge(symbolize(updates))
      @storage.set_session(resource_id, merged)
    end

    def pluck(hash, *keys)
      return nil if hash.nil?

      keys.each do |key|
        value = hash[key] || hash[key.to_s]
        return value if value && !value.to_s.empty?
      end
      nil
    end

    def symbolize(hash)
      return {} if hash.nil?

      hash.transform_keys(&:to_sym)
    end
  end
end
