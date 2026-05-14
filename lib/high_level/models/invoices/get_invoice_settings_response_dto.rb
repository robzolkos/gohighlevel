# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      GetInvoiceSettingsResponseDto = Data.define(:alt_id, :alt_type, :terms_note, :estimates_terms_note, :title, :estimates_title, :invoice_number_prefix, :estimate_number_prefix, :due_after_x_days, :estimates_expire_after_x_days, :minimum_percentage_partial_payment, :custom_fields, :custom_notification, :business_details, :sender_configuration, :product_settings, :reminder_settings, :late_fees_configuration, :tips_configuration, :payment_methods)
    end
  end
end
