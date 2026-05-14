# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      UpdateCouponParams = Data.define(:alt_id, :alt_type, :name, :code, :discount_type, :discount_value, :start_date, :end_date, :usage_limit, :product_ids, :apply_to_future_payments, :apply_to_future_payments_config, :limit_per_customer, :id)
    end
  end
end
