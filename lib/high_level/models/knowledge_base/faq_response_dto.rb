# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module KnowledgeBase
      FaqResponseDTO = Data.define(:id, :question, :question_lower_case, :answer, :knowledge_base_id, :location_id, :trained_url_id, :deleted, :created_at, :updated_at)
    end
  end
end
