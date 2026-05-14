# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      ProcessOutboundMessageBodyDto = Data.define(:type, :attachments, :conversation_id, :conversation_provider_id, :alt_id, :date, :call)
    end
  end
end
