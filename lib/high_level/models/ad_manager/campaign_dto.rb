# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      CampaignDTO = Data.define(:id, :name, :location_id, :advertising_channel_type, :advertising_channel_sub_type, :goal_type, :budget, :audience, :network_settings, :bidding_strategy, :assets, :is_eu_political_ads, :ad_groups, :campaign_goal, :ad_schedule, :publishing_status, :google_ad_account_id, :unpublished_changes, :maximum_cpc, :google_campaign_id, :source, :advanced_options)
    end
  end
end
