# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AdManager
      LeadFormAssetPayloadDTO = Data.define(:resource_name, :headline, :description, :business_name, :privacy_policy_url, :fields, :call_to_action_type, :call_to_action_description, :background_image_asset, :desired_intent, :custom_question_fields, :post_submit_headline, :post_submit_description, :post_submit_call_to_action_type, :final_urls)
    end
  end
end
