# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      CreateLeadFormDTO = Data.define(:type, :name, :location_id, :greeting_card, :questions, :question_page_headline, :privacy_policy_link, :privacy_policy_text, :custom_disclaimer, :thank_you_page)
    end
  end
end
