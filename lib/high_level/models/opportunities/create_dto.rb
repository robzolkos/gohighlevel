# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/opportunities.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Opportunities
      CreateDto = Data.define(:pipeline_id, :location_id, :name, :pipeline_stage_id, :status, :contact_id, :monetary_value, :assigned_to, :custom_fields)
    end
  end
end
