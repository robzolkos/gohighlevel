# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      UpdatePriceDto = Data.define(:name, :type, :currency, :amount, :recurring, :description, :membership_offers, :trial_period, :total_cycles, :setup_fee, :variant_option_ids, :compare_at_price, :location_id, :user_id, :meta, :track_inventory, :available_quantity, :allow_out_of_stock_purchases, :sku, :shipping_options, :is_digital_product, :digital_delivery)
    end
  end
end
