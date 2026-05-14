# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      SubscriptionResponseSchema = Data.define(:id, :alt_id, :alt_type, :contact_id, :contact_name, :contact_email, :currency, :amount, :status, :live_mode, :entity_type, :entity_id, :entity_source_type, :entity_source_name, :entity_source_id, :entity_source_meta, :subscription_id, :subscription_snapshot, :payment_provider_type, :payment_provider_connected_account, :ip_address, :created_at, :updated_at, :created_by)
    end
  end
end
