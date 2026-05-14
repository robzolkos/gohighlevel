# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ProcessMessageBodyDto = Data.define(:type, :attachments, :message, :conversation_id, :contact_id, :conversation_provider_id, :html, :subject, :email_from, :email_to, :email_cc, :email_bcc, :email_message_id, :alt_id, :direction, :date, :call)
    end
  end
end
