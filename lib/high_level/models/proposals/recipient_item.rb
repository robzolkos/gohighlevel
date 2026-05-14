# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/proposals.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Proposals
      RecipientItem = Data.define(:id, :first_name, :last_name, :email, :phone_number, :phone, :has_completed, :role, :is_primary, :signing_order, :img_url, :ip, :user_agent, :signed_date, :contact_name, :country, :entity_name, :initials_img_url, :last_viewed_at, :share_link)
    end
  end
end
