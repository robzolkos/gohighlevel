# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/saas-api.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module SaasApi
      SaasLocationDto = Data.define(:location_id, :company_id, :saas_mode, :subscription_id, :customer_id, :name, :email, :provider_location_id, :is_saa_sv2, :subscription_info)
    end
  end
end
