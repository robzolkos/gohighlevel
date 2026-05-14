# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      UpdateInvoiceDto = Data.define(:alt_id, :alt_type, :name, :title, :currency, :description, :business_details, :invoice_number, :contact_id, :contact_details, :terms_notes, :discount, :invoice_items, :automatic_taxes_enabled, :live_mode, :issue_date, :due_date, :payment_schedule, :tips_configuration, :xero_details, :invoice_number_prefix, :payment_methods, :attachments, :miscellaneous_charges)
    end
  end
end
