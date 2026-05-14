# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversation-ai.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module ConversationAi
      EmployeeResponseDTO = Data.define(:id, :name, :business_name, :mode, :channels, :wait_time, :wait_time_unit, :sleep_enabled, :sleep_time, :sleep_time_unit, :actions, :is_primary, :auto_pilot_max_messages, :goal, :personality, :instructions, :knowledge_base_ids, :sleep_on_manual_message, :sleep_on_workflow_message)
    end
  end
end
