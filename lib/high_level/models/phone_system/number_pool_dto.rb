# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module PhoneSystem
      NumberPoolDto = Data.define(:id, :name, :location_id, :numbers, :forwarding_number, :whisper, :whisper_message, :call_recording, :is_active, :inbound_call_service)
    end
  end
end
