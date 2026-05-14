# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      GetOrderResponseSchema = Data.define(:id, :alt_id, :alt_type, :contact_id, :currency, :amount, :status, :live_mode, :created_at, :updated_at, :fulfillment_status, :contact_snapshot, :amount_summary, :source, :items, :coupon, :tracking_id, :fingerprint, :meta, :mark_as_test, :trace_id, :automatic_taxes_calculated, :tax_calculation_provider, :created_by)
    end
  end
end
