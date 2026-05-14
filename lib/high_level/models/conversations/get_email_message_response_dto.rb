# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      GetEmailMessageResponseDto = Data.define(:id, :alt_id, :thread_id, :location_id, :contact_id, :conversation_id, :date_added, :subject, :body, :direction, :status, :content_type, :attachments, :provider, :from, :to, :cc, :bcc, :reply_to_message_id, :source, :conversation_provider_id)
    end
  end
end
