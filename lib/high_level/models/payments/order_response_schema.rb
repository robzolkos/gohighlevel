# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      OrderResponseSchema = Data.define(:id, :alt_id, :alt_type, :contact_id, :contact_name, :contact_email, :currency, :amount, :subtotal, :discount, :status, :live_mode, :total_products, :source_type, :source_name, :source_id, :source_meta, :coupon_code, :created_at, :updated_at, :source_sub_type, :fulfillment_status, :onetime_products, :recurring_products, :created_by)
    end
  end
end
