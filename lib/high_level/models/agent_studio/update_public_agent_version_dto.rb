# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/agent-studio.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module AgentStudio
      UpdatePublicAgentVersionDTO = Data.define(:location_id, :version_name, :description, :nodes, :edges, :global_variables, :input_variables, :runtime_variables, :global_config, :user_id, :user_name)
    end
  end
end
