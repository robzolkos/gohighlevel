# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      AutoPaymentDetailsDto = Data.define(:enable, :type, :payment_method_id, :customer_id, :card, :us_bank_account, :sepa_direct_debit, :bacs_direct_debit, :becs_direct_debit, :card_id, :provider)
    end
  end
end
