# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Invoices
      CustomNotificationItemDto = Data.define(:enabled, :email_template, :sms_template, :from_name, :from_email, :email_subject, :default_email_template_id)
    end
  end
end
