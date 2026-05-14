# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/saas-api.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module SaasApi
      SaasPlanResponseDto = Data.define(:plan_id, :company_id, :title, :description, :saas_products, :add_ons, :plan_level, :trial_period, :setup_fee, :user_limit, :contact_limit, :prices, :category_id, :snapshot_id, :provider_location_id, :product_id, :is_saa_sv2, :created_at, :updated_at)
    end
  end
end
