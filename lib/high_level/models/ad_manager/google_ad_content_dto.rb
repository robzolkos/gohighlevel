# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      GoogleAdContentDTO = Data.define(:id, :name, :media_type, :headlines, :long_headlines, :descriptions, :final_url, :path1, :path2, :is_deleted, :ad_error, :publishing_status, :ad_id, :ad_campaign_id, :ad_group_id, :google_ad_id, :media, :call_to_action_label, :business_name, :youtube_video_links, :carousel_cards, :placements, :custom_channels)
    end
  end
end
