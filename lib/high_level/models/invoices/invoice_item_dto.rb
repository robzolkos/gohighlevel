# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      InvoiceItemDto = Data.define(:name, :description, :product_id, :price_id, :currency, :amount, :qty, :taxes, :automatic_tax_category_id, :is_setup_fee_item, :type, :tax_inclusive)
    end
  end
end
