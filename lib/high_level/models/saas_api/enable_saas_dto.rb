# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/saas-api.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module SaasApi
      EnableSaasDto = Data.define(:stripe_account_id, :name, :email, :stripe_customer_id, :company_id, :is_saa_sv2, :contact_id, :provider_location_id, :description, :saas_plan_id, :price_id)
    end
  end
end
