# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      GetTxnResponseSchema = Data.define(:id, :alt_type, :alt_id, :contact_id, :contact_snapshot, :currency, :amount, :status, :live_mode, :created_at, :updated_at, :entity_type, :entity_id, :entity_source, :charge_id, :charge_snapshot, :invoice_id, :subscription_id, :payment_provider, :ip_address, :meta, :mark_as_test, :is_parent, :amount_refunded, :receipt_id, :qbo_synced, :qbo_response, :trace_id, :merged_from_contact_id, :created_by)
    end
  end
end
