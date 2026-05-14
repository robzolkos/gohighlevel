# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      GetMessageResponseDto = Data.define(:id, :type, :message_type, :location_id, :contact_id, :conversation_id, :date_added, :body, :direction, :status, :content_type, :attachments, :meta, :source, :user_id, :conversation_provider_id, :chat_widget_id)
    end
  end
end
