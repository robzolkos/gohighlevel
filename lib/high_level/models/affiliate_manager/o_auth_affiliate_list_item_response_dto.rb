# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/affiliate-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AffiliateManager
      OAuthAffiliateListItemResponseDto = Data.define(:id, :first_name, :last_name, :phone, :deleted, :location_id, :active, :address, :avatar, :created_at, :created_by, :facebook_url, :instagram_url, :linked_in_url, :twitter_url, :youtube_url, :website_url, :contact_id, :campaign_ids, :vat_id, :updated_at, :w8_form, :w9_form, :last_updated_by, :email, :revenue, :customer, :lead, :dropped_customer, :click_count, :paid, :currency, :owned)
    end
  end
end
