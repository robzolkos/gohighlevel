# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      CreateCalendarNotificationDTO = Data.define(:receiver_type, :channel, :notification_type, :is_active, :template_id, :body, :subject, :after_time, :before_time, :additional_email_ids, :additional_phone_numbers, :selected_users, :from_address, :from_name, :from_number)
    end
  end
end
