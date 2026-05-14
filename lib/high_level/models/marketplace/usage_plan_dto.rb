# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/marketplace.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Marketplace
      UsagePlanDTO = Data.define(:product_type, :product_name, :usage_unit, :meter_id, :meter_name, :fixed_price_per_unit, :price_type, :min_price_per_unit, :max_price_per_unit, :execution_limit_per_cycle)
    end
  end
end
