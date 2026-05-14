# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/companies.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Companies
      IOnboardingDto = Data.define(:pending, :have_website, :website_url, :industry_served, :customer_count, :tools, :location, :conversation_demo, :location_id, :snapshot_id, :plan_id, :affiliate_signup, :has_joined_kickoff_call, :kickoff_action_taken, :has_joined_implementation_call, :version, :meta_data)
    end
  end
end
