# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/marketplace.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Marketplace
      RaiseChargeBodyDTO = Data.define(:app_id, :meter_id, :event_id, :user_id, :location_id, :company_id, :description, :price, :units, :event_time)
    end
  end
end
