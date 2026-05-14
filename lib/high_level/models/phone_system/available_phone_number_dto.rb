# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module PhoneSystem
      AvailablePhoneNumberDto = Data.define(:phone_number, :friendly_name, :iso_country, :lata, :locality, :rate_center, :latitude, :longitude, :region, :postal_code, :address_requirements, :beta, :capabilities, :price)
    end
  end
end
