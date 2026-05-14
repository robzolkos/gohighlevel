# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      BlockSlotCreateRequestDTO = Data.define(:title, :calendar_id, :assigned_user_id, :location_id, :start_time, :end_time)
    end
  end
end
