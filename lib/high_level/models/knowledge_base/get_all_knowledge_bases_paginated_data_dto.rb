# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module KnowledgeBase
      GetAllKnowledgeBasesPaginatedDataDTO = Data.define(:knowledge_bases, :active_count, :has_more, :last_knowledge_base_id)
    end
  end
end
