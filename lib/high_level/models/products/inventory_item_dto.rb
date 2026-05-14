# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      InventoryItemDto = Data.define(:id, :name, :available_quantity, :sku, :allow_out_of_stock_purchases, :product, :updated_at, :image, :product_name)
    end
  end
end
