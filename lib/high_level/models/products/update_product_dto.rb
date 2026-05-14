# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      UpdateProductDto = Data.define(:name, :location_id, :description, :product_type, :image, :statement_descriptor, :available_in_store, :medias, :variants, :collection_ids, :is_taxes_enabled, :taxes, :automatic_tax_category_id, :is_label_enabled, :label, :slug, :seo, :tax_inclusive, :prices)
    end
  end
end
