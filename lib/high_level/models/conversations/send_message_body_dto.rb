# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Conversations
      SendMessageBodyDto = Data.define(:type, :sub_type, :contact_id, :appointment_id, :attachments, :email_from, :email_cc, :email_bcc, :html, :message, :subject, :reply_message_id, :template_id, :thread_id, :scheduled_timestamp, :conversation_provider_id, :email_to, :custom_subtype_id, :email_reply_mode, :from_number, :to_number, :forward, :status, :uses_native_scheduling_ai, :optimization_period)
    end
  end
end
