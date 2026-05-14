# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/voice-ai.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module VoiceAi
      CallLogDTO = Data.define(:id, :contact_id, :agent_id, :is_agent_deleted, :from_number, :created_at, :duration, :trial_call, :executed_call_actions, :summary, :transcript, :translation, :extracted_data, :message_id)
    end
  end
end
