# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/opportunities.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Opportunities
      SearchOpportunitiesResponseSchema = Data.define(:id, :name, :monetary_value, :pipeline_id, :pipeline_stage_id, :assigned_to, :status, :source, :last_status_change_at, :last_stage_change_at, :last_action_date, :index_version, :created_at, :updated_at, :contact_id, :location_id, :contact, :notes, :tasks, :calendar_events, :lost_reason_id, :custom_fields, :followers, :external_object_id)
    end
  end
end
