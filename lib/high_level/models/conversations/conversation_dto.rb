# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ConversationDto = Data.define(:id, :location_id, :contact_id, :assigned_to, :user_id, :last_message_body, :last_message_date, :last_message_type, :unread_count, :inbox, :starred, :deleted)
    end
  end
end
