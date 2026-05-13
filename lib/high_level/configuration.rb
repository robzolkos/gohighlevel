# frozen_string_literal: true

module HighLevel
  Configuration = Data.define(
    :api_version,
    :base_url,
    :private_integration_token,
    :agency_access_token,
    :location_access_token,
    :client_id,
    :client_secret,
    :session_storage,
    :logger,
    :instrumenter
  ) do
    def initialize(
      api_version: "2021-07-28",
      base_url: "https://services.leadconnectorhq.com",
      private_integration_token: nil,
      agency_access_token: nil,
      location_access_token: nil,
      client_id: nil,
      client_secret: nil,
      session_storage: nil,
      logger: nil,
      instrumenter: nil
    )
      super
    end
  end
end
