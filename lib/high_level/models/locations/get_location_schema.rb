# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      GetLocationSchema = Data.define(:id, :name, :phone, :email, :address, :city, :state, :country, :postal_code, :website, :timezone, :settings, :social)
    end
  end
end
