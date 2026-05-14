# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/brand-boards.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module BrandBoards
      GetBrandBoardSuccessDTO = Data.define(:id, :location_id, :name, :logos, :colors, :fonts, :default, :deleted, :parent_id, :folder_id, :origin_id, :meta, :created_at, :updated_at)
    end
  end
end
