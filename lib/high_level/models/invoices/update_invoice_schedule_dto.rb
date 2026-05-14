# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      UpdateInvoiceScheduleDto = Data.define(:alt_id, :alt_type, :name, :contact_details, :schedule, :live_mode, :business_details, :currency, :items, :discount, :terms_notes, :title, :attachments, :miscellaneous_charges)
    end
  end
end
