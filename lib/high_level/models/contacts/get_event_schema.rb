# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Contacts
      GetEventSchema = Data.define(:id, :calendar_id, :status, :title, :assigned_user_id, :notes, :start_time, :end_time, :address, :location_id, :contact_id, :group_id, :appointment_status, :users, :date_added, :date_updated, :assigned_resources)
    end
  end
end
