# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ForwardConfigDto = Data.define(:is_forwarded, :forward_whole_thread, :message_id, :email_message_id, :source_contact_id, :source_conversation_id, :to_email, :recipient_contact_id, :recipient_conversation_id)
    end
  end
end
