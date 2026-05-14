# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/opportunities.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Opportunities
      UpsertOpportunityDto = Data.define(:id, :pipeline_id, :location_id, :followers, :is_remove_all_followers, :followers_action_type, :name, :status, :pipeline_stage_id, :monetary_value, :assigned_to, :lost_reason_id)
    end
  end
end
