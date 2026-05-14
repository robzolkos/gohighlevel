# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      GetScheduleResponseDto = Data.define(:id, :status, :live_mode, :alt_id, :alt_type, :name, :schedule, :invoices, :business_details, :currency, :contact_details, :discount, :items, :total, :title, :terms_notes, :compiled_terms_notes, :created_at, :updated_at)
    end
  end
end
