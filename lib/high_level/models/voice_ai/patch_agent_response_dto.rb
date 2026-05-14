# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/voice-ai.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module VoiceAi
      PatchAgentResponseDTO = Data.define(:id, :location_id, :agent_name, :business_name, :welcome_message, :agent_prompt, :voice_id, :language, :patience_level, :max_call_duration, :send_user_idle_reminders, :reminder_after_idle_time_seconds, :inbound_number, :number_pool_id, :call_end_workflow_ids, :send_post_call_notification_to, :agent_working_hours, :timezone, :is_agent_as_backup_disabled, :translation)
    end
  end
end
