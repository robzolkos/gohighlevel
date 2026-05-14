# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      CreateInvoiceTemplateDto = Data.define(:alt_id, :alt_type, :internal, :name, :business_details, :currency, :items, :automatic_taxes_enabled, :discount, :terms_notes, :title, :tips_configuration, :late_fees_configuration, :invoice_number_prefix, :payment_methods, :attachments, :miscellaneous_charges)
    end
  end
end
