# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Payments
      CustomRRuleOptionsDto = Data.define(:interval_type, :interval, :start_date, :start_time, :end_date, :end_time, :day_of_month, :day_of_week, :num_of_week, :month_of_year, :count, :days_before)
    end
  end
end
