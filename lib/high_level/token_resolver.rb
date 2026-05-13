# frozen_string_literal: true

module HighLevel
  # Resolves the bearer token for a single request based on OpenAPI security
  # requirements + request data.
  #
  # Ported from vendor/highlevel-api-sdk/lib/HighLevel.ts @ b1a1454
  # (getTokenForSecurity + extractResourceId).
  #
  # Priority chain:
  #   1. Configuration#private_integration_token always wins.
  #   2. If the op declares Agency-Access-Only:
  #        agency_access_token, else storage(resource_id), else raise.
  #   3. If the op declares Location-Access-Only:
  #        location_access_token, else storage(resource_id), else raise.
  #   4. If the op declares Agency-Access, Location-Access, or bearer (flexible):
  #        agency_access_token, else location_access_token,
  #        else storage(resource_id), else raise.
  #   5. No specific requirements: storage(resource_id), else raise.
  class TokenResolver
    Result = Data.define(:token, :source)

    AGENCY_ONLY    = "Agency-Access-Only"
    LOCATION_ONLY  = "Location-Access-Only"
    AGENCY_ACCESS  = "Agency-Access"
    LOCATION_ACCESS = "Location-Access"
    BEARER = "bearer"

    LOCATION_REQS = [LOCATION_ACCESS, LOCATION_ONLY, BEARER].freeze
    AGENCY_REQS   = [AGENCY_ACCESS, AGENCY_ONLY].freeze

    def initialize(config:, storage: nil)
      @config = config
      @storage = storage
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def resolve(security_requirements: [], headers: {}, query: {}, body: {}, preference: nil)
      requirements = Array(security_requirements)

      if @config.private_integration_token
        return Result.new(token: @config.private_integration_token,
                          source: :private_integration_token)
      end

      resource_id = extract_resource_id(
        security_requirements: requirements,
        headers: headers, query: query, body: body, preference: preference
      )

      if requirements.include?(AGENCY_ONLY)
        return resolve_only(@config.agency_access_token, :agency_access_token, resource_id,
                            "Agency Access Token required but not available")
      end

      if requirements.include?(LOCATION_ONLY)
        return resolve_only(@config.location_access_token, :location_access_token, resource_id,
                            "Location Access Token required but not available")
      end

      return resolve_flexible(resource_id) if requirements.intersect?([AGENCY_ACCESS, LOCATION_ACCESS, BEARER])

      storage_token = fetch_storage_token(resource_id)
      return Result.new(token: storage_token, source: :storage) if storage_token

      raise ConfigurationError, "No authentication token available"
    end

    # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
    def extract_resource_id(security_requirements:, headers: {}, query: {}, body: {}, preference: nil)
      headers_hash = stringify_keys(headers)

      company_id = first_present(headers_hash, "x-company-id", "companyId", "company-id")
      location_id = first_present(headers_hash, "x-location-id", "locationId", "location-id")

      company_id  ||= first_present(query, :companyId, "companyId", :company_id, "company_id")
      location_id ||= first_present(query, :locationId, "locationId", :location_id, "location_id")

      if company_id.nil? && location_id.nil? && body.is_a?(Hash)
        company_id  = first_present(body, :companyId, "companyId", :company_id, "company_id")
        location_id = first_present(body, :locationId, "locationId", :location_id, "location_id")
      end

      needs_location = security_requirements.intersect?(LOCATION_REQS)
      needs_agency   = security_requirements.intersect?(AGENCY_REQS)

      if needs_location && needs_agency
        return company_id  if preference == :company  && company_id
        return location_id if preference == :location && location_id
      end

      return location_id if needs_location
      return company_id  if needs_agency

      nil
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

    private

    def resolve_only(direct_token, source, resource_id, error_message)
      return Result.new(token: direct_token, source: source) if direct_token

      storage_token = fetch_storage_token(resource_id)
      return Result.new(token: storage_token, source: :storage) if storage_token

      raise ConfigurationError, error_message
    end

    def resolve_flexible(resource_id)
      return Result.new(token: @config.agency_access_token, source: :agency_access_token) if @config.agency_access_token

      if @config.location_access_token
        return Result.new(token: @config.location_access_token, source: :location_access_token)
      end

      storage_token = fetch_storage_token(resource_id)
      return Result.new(token: storage_token, source: :storage) if storage_token

      raise ConfigurationError, "Authentication token required but not available"
    end

    def fetch_storage_token(resource_id)
      return nil if @storage.nil? || resource_id.nil? || resource_id.to_s.empty?

      session = @storage.get_session(resource_id)
      return nil if session.nil?

      session[:access_token] || session["access_token"]
    end

    def first_present(hash, *keys)
      return nil unless hash.is_a?(Hash)

      keys.each do |key|
        value = hash[key]
        return value if value && !value.to_s.empty?
      end
      nil
    end

    def stringify_keys(hash)
      return {} unless hash.is_a?(Hash)

      hash.transform_keys(&:to_s)
    end
  end
end
