# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      RecordPaymentDto = Data.define(:alt_id, :alt_type, :mode, :card, :cheque, :notes, :amount, :meta, :payment_schedule_ids, :fulfilled_at)
    end
  end
end
