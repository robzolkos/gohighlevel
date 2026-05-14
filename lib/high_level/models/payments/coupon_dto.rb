# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      CouponDto = Data.define(:id, :usage_count, :limit_per_customer, :alt_id, :alt_type, :name, :code, :discount_type, :discount_value, :status, :start_date, :end_date, :apply_to_future_payments, :apply_to_future_payments_config, :user_id, :created_at, :updated_at)
    end
  end
end
