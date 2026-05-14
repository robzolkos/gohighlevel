# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/affiliate-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AffiliateManager
      CommissionListItemResponseDto = Data.define(:id, :product_id, :product_name, :qty, :product_commission, :commission_amount, :amount, :unit_discount, :campaign_name, :commission, :commission_type, :transaction_at, :transaction_id, :affiliate_id, :payout_id, :status, :currency, :is_trial, :customer, :created_at, :event_id, :campaign, :affiliate, :due_at, :live_mode, :tier)
    end
  end
end
