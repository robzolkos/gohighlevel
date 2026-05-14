# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      CustomFieldSchema = Data.define(:id, :name, :field_key, :placeholder, :data_type, :position, :picklist_options, :picklist_image_options, :is_allowed_custom_option, :is_multi_file_allowed, :max_file_limit, :location_id, :model)
    end
  end
end
