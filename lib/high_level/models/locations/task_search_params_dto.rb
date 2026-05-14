# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      TaskSearchParamsDto = Data.define(:contact_id, :completed, :assigned_to, :query, :limit, :skip, :business_id)
    end
  end
end
