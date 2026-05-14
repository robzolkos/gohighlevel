# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module PhoneSystem
      TwilioAccountResponseDto = Data.define(:id, :account_sid, :under_ghl_account, :validate_sms, :location_id, :migration_status, :migration_numbers, :assigned_to_numbers, :numbers, :number_name, :new_account_sid)
    end
  end
end
