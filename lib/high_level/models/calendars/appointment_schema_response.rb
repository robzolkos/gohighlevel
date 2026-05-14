# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      AppointmentSchemaResponse = Data.define(:calendar_id, :location_id, :contact_id, :start_time, :end_time, :title, :meeting_location_type, :appointment_status, :assigned_user_id, :address, :is_recurring, :rrule, :id)
    end
  end
end
