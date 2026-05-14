# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      EstimateResponseDto = Data.define(:alt_id, :alt_type, :id, :live_mode, :deleted, :name, :currency, :business_details, :items, :discount, :title, :estimate_number_prefix, :attachments, :updated_by, :total, :created_at, :updated_at, :v, :automatic_taxes_enabled, :terms_notes, :company_id, :contact_details, :issue_date, :expiry_date, :sent_by, :automatic_taxes_calculated, :meta, :estimate_action_history, :sent_to, :frequency_settings, :last_visited_at, :totalamount_in_usd, :auto_invoice, :trace_id)
    end
  end
end
