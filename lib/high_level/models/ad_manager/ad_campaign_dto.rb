# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      AdCampaignDTO = Data.define(:id, :locale, :name, :publishing_status, :media_type, :audience, :unit_cost, :campaign_type, :ad_campaign_group_id, :ad_campaign_id, :ads, :linked_in_error, :meta)
    end
  end
end
