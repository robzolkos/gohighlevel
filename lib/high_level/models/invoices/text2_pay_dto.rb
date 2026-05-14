# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      Text2PayDto = Data.define(:alt_id, :alt_type, :name, :currency, :items, :terms_notes, :title, :contact_details, :invoice_number, :issue_date, :due_date, :sent_to, :live_mode, :automatic_taxes_enabled, :payment_schedule, :late_fees_configuration, :tips_configuration, :invoice_number_prefix, :payment_methods, :attachments, :miscellaneous_charges, :id, :include_terms_note, :action, :user_id, :discount, :business_details)
    end
  end
end
