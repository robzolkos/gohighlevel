# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ProcessMessageResponseDto = Data.define(:success, :conversation_id, :message_id, :message, :contact_id, :date_added, :email_message_id)
    end
  end
end
