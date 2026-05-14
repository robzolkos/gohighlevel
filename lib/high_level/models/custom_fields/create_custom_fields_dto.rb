# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/custom-fields.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module CustomFields
      CreateCustomFieldsDTO = Data.define(:location_id, :name, :description, :placeholder, :show_in_forms, :options, :accepted_formats, :data_type, :field_key, :object_key, :max_file_limit, :allow_custom_option, :parent_id)
    end
  end
end
