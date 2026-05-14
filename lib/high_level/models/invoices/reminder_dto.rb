# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      ReminderDto = Data.define(:enabled, :email_template, :sms_template, :email_subject, :reminder_id, :reminder_name, :reminder_time, :interval_type, :max_reminders, :reminder_invoice_condition, :reminder_number, :start_time, :end_time, :timezone)
    end
  end
end
