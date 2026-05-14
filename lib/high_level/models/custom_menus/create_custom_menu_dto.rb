# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/custom-menus.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module CustomMenus
      CreateCustomMenuDTO = Data.define(:title, :url, :icon, :show_on_company, :show_on_location, :show_to_all_locations, :open_mode, :locations, :user_role, :allow_camera, :allow_microphone)
    end
  end
end
