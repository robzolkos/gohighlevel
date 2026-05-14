# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/affiliate-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AffiliateManager
      PayoutListItemResponseDto = Data.define(:id, :location_id, :affiliate_id, :campaign_id, :currency, :amount, :status, :payout_month, :due_at, :paid_at, :paid_meta, :paid_method, :alt_id, :deleted, :is_migrated, :created_at, :updated_at, :campaign, :affiliate_name, :affiliate_email, :payout_method, :affiliate)
    end
  end
end
