# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/businesses.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Businesses
      BusinessDto = Data.define(:id, :name, :phone, :email, :website, :address, :city, :description, :state, :postal_code, :country, :updated_by, :location_id, :created_by, :created_at, :updated_at)
    end
  end
end
