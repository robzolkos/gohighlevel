# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      CalendarNotificationResponseDTO = Data.define(:id, :receiver_type, :additional_email_ids, :additional_phone_numbers, :channel, :notification_type, :is_active, :additional_whatsapp_numbers, :template_id, :body, :subject, :after_time, :before_time, :selected_users, :deleted)
    end
  end
end
