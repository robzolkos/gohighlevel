# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      RecurringTaskResponseDTO = Data.define(:id, :title, :description, :location_id, :updated_at, :created_at, :rrule_options, :total_occurrence, :deleted, :assigned_to, :contact_id)
    end
  end
end
