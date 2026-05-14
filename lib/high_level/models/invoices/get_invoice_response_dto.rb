# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      GetInvoiceResponseDto = Data.define(:id, :status, :live_mode, :amount_paid, :alt_id, :alt_type, :name, :business_details, :invoice_number, :currency, :contact_details, :issue_date, :due_date, :discount, :invoice_items, :total, :title, :amount_due, :created_at, :updated_at, :automatic_taxes_enabled, :automatic_taxes_calculated, :payment_schedule, :total_summary, :reminders_configuration)
    end
  end
end
