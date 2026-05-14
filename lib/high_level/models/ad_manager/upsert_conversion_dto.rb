# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      UpsertConversionDTO = Data.define(:location_id, :conversion_id, :name, :type, :category, :value_settings, :counting_type, :attribution_model, :click_through_window)
    end
  end
end
