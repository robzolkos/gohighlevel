# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ConversationCreateResponseDto = Data.define(:id, :date_updated, :date_added, :deleted, :contact_id, :location_id, :last_message_date, :assigned_to)
    end
  end
end
