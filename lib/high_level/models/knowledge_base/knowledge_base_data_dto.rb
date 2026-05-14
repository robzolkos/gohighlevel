# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module KnowledgeBase
      KnowledgeBaseDataDTO = Data.define(:id, :name, :name_lower_case, :location_id, :kb_metadata, :deleted, :created_at, :updated_at)
    end
  end
end
