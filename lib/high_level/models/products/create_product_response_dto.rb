# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      CreateProductResponseDto = Data.define(:id, :description, :variants, :location_id, :name, :product_type, :available_in_store, :created_at, :updated_at, :statement_descriptor, :image, :collection_ids, :is_taxes_enabled, :taxes, :automatic_tax_category_id, :label, :slug)
    end
  end
end
