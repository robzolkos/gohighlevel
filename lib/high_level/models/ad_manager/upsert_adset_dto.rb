# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      UpsertAdsetDTO = Data.define(:id, :location_id, :name, :page_id, :instagram_actor_id, :messaging_platforms, :whatsapp_number, :audience, :budget, :conversion_location, :custom_event_type, :pixel_id, :campaign_id)
    end
  end
end
