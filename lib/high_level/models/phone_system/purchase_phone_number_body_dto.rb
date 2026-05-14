# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module PhoneSystem
      PurchasePhoneNumberBodyDto = Data.define(:phone_number, :country_code, :number_type, :address_sid, :bundle_sid, :locality, :region, :fingerprint_id, :skip_location_kyc)
    end
  end
end
