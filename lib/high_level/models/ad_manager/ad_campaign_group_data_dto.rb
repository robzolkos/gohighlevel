# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      AdCampaignGroupDataDTO = Data.define(:id, :location_id, :budget, :ad_campaigns, :ad_budget_optimization, :objective_type, :name, :ad_campaign_group_id, :publishing_status, :linked_in_ad_account_id, :unpublished_changes, :meta, :linked_in_error)
    end
  end
end
