# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Products
      BulkEditProductDto = Data.define(:id, :name, :description, :image, :available_in_store, :prices, :collection_ids, :is_label_enabled, :is_taxes_enabled, :seo, :slug, :automatic_tax_category_id, :tax_inclusive, :taxes, :medias, :label)
    end
  end
end
