# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/store.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Store
      GetAvailableShippingRates = Data.define(:alt_id, :alt_type, :country, :address, :amount_available, :total_order_amount, :weight_available, :total_order_weight, :source, :products, :coupon_code)
    end
  end
end
