# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      CalendarEventDTO = Data.define(:id, :address, :title, :calendar_id, :location_id, :contact_id, :group_id, :appointment_status, :assigned_user_id, :users, :notes, :description, :is_recurring, :rrule, :start_time, :end_time, :date_added, :date_updated, :assigned_resources, :created_by, :master_event_id)
    end
  end
end
