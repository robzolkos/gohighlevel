# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      UploadFilesDto = Data.define(:conversation_id, :contact_id, :location_id, :attachment_urls, :chat_service_sid, :is_group_sms)
    end
  end
end
