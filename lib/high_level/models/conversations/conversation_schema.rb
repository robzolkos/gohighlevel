# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ConversationSchema = Data.define(:id, :contact_id, :location_id, :last_message_body, :last_message_type, :type, :unread_count, :full_name, :contact_name, :email, :phone)
    end
  end
end
