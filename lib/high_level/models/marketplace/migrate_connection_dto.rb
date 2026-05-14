# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/marketplace.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Marketplace
      MigrateConnectionDto = Data.define(:type, :location_id, :app_id, :app_version_id, :account_id, :api_key, :basic_credentials, :access_token, :refresh_token, :expiry_in, :expiry_at, :scopes, :display_name, :is_default)
    end
  end
end
