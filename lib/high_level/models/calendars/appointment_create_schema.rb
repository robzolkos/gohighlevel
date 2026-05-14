# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      AppointmentCreateSchema = Data.define(:title, :meeting_location_type, :meeting_location_id, :override_location_config, :appointment_status, :assigned_user_id, :description, :address, :ignore_date_range, :to_notify, :ignore_free_slot_validation, :rrule, :calendar_id, :location_id, :contact_id, :start_time, :end_time)
    end
  end
end
