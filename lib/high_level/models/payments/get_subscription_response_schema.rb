# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      GetSubscriptionResponseSchema = Data.define(:id, :alt_type, :alt_id, :contact_id, :contact_snapshot, :coupon, :currency, :amount, :status, :live_mode, :entity_type, :entity_id, :entity_source, :subscription_id, :subscription_snapshot, :payment_provider, :ip_address, :created_at, :updated_at, :meta, :mark_as_test, :schedule, :auto_payment, :recurring_product, :canceled_at, :canceled_by, :trace_id, :created_by)
    end
  end
end
