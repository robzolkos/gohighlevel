# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      CreateEstimatesDto = Data.define(:alt_id, :alt_type, :name, :business_details, :currency, :items, :live_mode, :discount, :terms_notes, :title, :contact_details, :estimate_number, :issue_date, :expiry_date, :sent_to, :automatic_taxes_enabled, :meta, :send_estimate_details, :frequency_settings, :estimate_number_prefix, :user_id, :attachments, :auto_invoice, :miscellaneous_charges, :payment_schedule_config)
    end
  end
end
