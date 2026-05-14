# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/opportunities.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Opportunities
      OpportunitySearchBodyDTO = Data.define(:location_id, :query, :limit, :page, :search_after, :additional_details)
    end
  end
end
