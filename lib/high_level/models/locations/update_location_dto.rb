# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      UpdateLocationDto = Data.define(:name, :phone, :company_id, :address, :city, :state, :country, :postal_code, :website, :timezone, :prospect_info, :settings, :social, :twilio, :mailgun, :snapshot)
    end
  end
end
