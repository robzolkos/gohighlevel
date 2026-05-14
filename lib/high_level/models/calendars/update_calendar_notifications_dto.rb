# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      UpdateCalendarNotificationsDTO = Data.define(:receiver_type, :additional_email_ids, :additional_phone_numbers, :selected_users, :channel, :notification_type, :is_active, :deleted, :template_id, :body, :subject, :after_time, :before_time, :from_address, :from_number, :from_name)
    end
  end
end
