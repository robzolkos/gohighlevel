# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      CreateCustomProvidersResponseSchema = Data.define(:name, :description, :payments_url, :query_url, :image_url, :id, :location_id, :marketplace_app_id, :payment_provider, :deleted, :created_at, :updated_at, :trace_id)
    end
  end
end
