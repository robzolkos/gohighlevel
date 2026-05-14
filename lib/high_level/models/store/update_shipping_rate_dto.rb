# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/store.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Store
      UpdateShippingRateDto = Data.define(:alt_id, :alt_type, :name, :description, :currency, :amount, :condition_type, :min_condition, :max_condition, :is_carrier_rate, :shipping_carrier_id, :percentage_of_rate_fee, :shipping_carrier_services)
    end
  end
end
