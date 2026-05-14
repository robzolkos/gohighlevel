# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      CustomNotificationDto = Data.define(:customer_send_invoice, :team_payment_success, :customer_payment_success, :team_auto_payment_success, :customer_auto_payment_success, :team_payment_failure, :customer_payment_failure, :team_auto_payment_failure, :customer_auto_payment_failure, :customer_auto_payment_info, :customer_auto_payment_amount_changed, :team_auto_payment_skip, :team_recurring_send_invoice_failed, :customer_send_estimate, :team_estimate_accepted, :team_estimate_declined)
    end
  end
end
