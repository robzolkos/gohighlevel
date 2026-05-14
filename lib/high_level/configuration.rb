# frozen_string_literal: true

module HighLevel
  # Immutable, per-client configuration. Every collaborator a {Client}
  # needs — credentials, base URL, session storage, instrumenter — is
  # supplied here; there is no global mutable state.
  #
  # @!attribute [r] api_version
  #   @return [String] the +Version+ header value sent on every request
  # @!attribute [r] base_url
  #   @return [String] the API base URL
  # @!attribute [r] private_integration_token
  #   @return [String, nil] a Private Integration Token
  # @!attribute [r] agency_access_token
  #   @return [String, nil] an agency-level access token
  # @!attribute [r] location_access_token
  #   @return [String, nil] a location-level access token
  # @!attribute [r] client_id
  #   @return [String, nil] the OAuth app client id
  # @!attribute [r] client_secret
  #   @return [String, nil] the OAuth app client secret
  # @!attribute [r] redirect_uri
  #   @return [String, nil] the OAuth redirect URI
  # @!attribute [r] session_storage
  #   @return [HighLevel::Storage::Base] the session store (defaults to a
  #     fresh {Storage::Memory})
  # @!attribute [r] logger
  #   @return [Logger, nil] an optional Ruby logger
  # @!attribute [r] instrumenter
  #   @return [#instrument, nil] an optional instrumenter (e.g.
  #     +ActiveSupport::Notifications+)
  Configuration = Data.define(
    :api_version,
    :base_url,
    :private_integration_token,
    :agency_access_token,
    :location_access_token,
    :client_id,
    :client_secret,
    :redirect_uri,
    :session_storage,
    :logger,
    :instrumenter
  ) do
    # @see Configuration the attribute list for every keyword argument
    def initialize(
      api_version: "2021-07-28",
      base_url: "https://services.leadconnectorhq.com",
      private_integration_token: nil,
      agency_access_token: nil,
      location_access_token: nil,
      client_id: nil,
      client_secret: nil,
      redirect_uri: nil,
      session_storage: Storage::Memory.new,
      logger: nil,
      instrumenter: nil
    )
      super
    end
  end
end
