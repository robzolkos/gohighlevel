# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      ScheduleObjectResponseDTO = Data.define(:id, :name, :location_id, :rules, :timezone, :date_added, :date_updated, :user_id, :calendar_ids, :deleted)
    end
  end
end
