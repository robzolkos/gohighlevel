# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Locations
      CustomRRulesOptions = Data.define(:interval_type, :interval, :start_date, :end_date, :day_of_month, :day_of_week, :month_of_year, :count, :create_task_if_over_due, :due_after_seconds)
    end
  end
end
