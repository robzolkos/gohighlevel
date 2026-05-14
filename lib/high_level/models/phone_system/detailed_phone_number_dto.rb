# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module PhoneSystem
      DetailedPhoneNumberDto = Data.define(:phone_number, :friendly_name, :sid, :country_code, :capabilities, :type, :is_default_number, :linked_user, :linked_ring_all_users, :inbound_call_service, :forwarding_number, :is_group_conversation_enabled, :address_sid, :bundle_sid, :date_added, :date_updated, :origin)
    end
  end
end
