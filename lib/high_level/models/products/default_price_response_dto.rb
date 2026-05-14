# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      DefaultPriceResponseDto = Data.define(:id, :membership_offers, :variant_option_ids, :location_id, :product, :user_id, :name, :type, :currency, :amount, :recurring, :created_at, :updated_at, :compare_at_price, :track_inventory, :available_quantity, :allow_out_of_stock_purchases)
    end
  end
end
