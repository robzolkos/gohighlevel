# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      GoogleAdGroupDTO = Data.define(:id, :ad_group_id, :name, :ad_campaign_id, :ad_content, :keywords, :publishing_status, :ad_group_error, :google_ad_group_id, :custom_channels, :selected_channels, :google_audience_id, :audience)
    end
  end
end
