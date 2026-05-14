# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      UpsertAdDTO = Data.define(:id, :location_id, :name, :primary_text, :headline, :description, :image_url, :media_type, :media, :multi_advertiser_ads, :campaign_id, :adset_id, :cta, :conversation_form_id, :destination_link, :destination_form_id)
    end
  end
end
