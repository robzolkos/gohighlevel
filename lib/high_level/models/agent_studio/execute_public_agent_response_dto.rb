# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/agent-studio.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AgentStudio
      ExecutePublicAgentResponseDTO = Data.define(:success, :execution_id, :interaction_id, :response, :type, :next_expected_input, :goal_completion, :execution_status, :flow_switch, :attachments, :generative_outputs)
    end
  end
end
