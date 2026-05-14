# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      CalendarNotification = Data.define(:type, :should_send_to_contact, :should_send_to_guest, :should_send_to_user, :should_send_to_selected_users, :selected_users)
    end
  end
end
