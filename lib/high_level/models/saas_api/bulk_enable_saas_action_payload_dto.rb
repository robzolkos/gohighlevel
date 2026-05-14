# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/saas-api.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module SaasApi
      BulkEnableSaasActionPayloadDto = Data.define(:price_id, :stripe_account_id, :saas_plan_id, :provider_location_id)
    end
  end
end
