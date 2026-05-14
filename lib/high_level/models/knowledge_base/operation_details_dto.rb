# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module KnowledgeBase
      OperationDetailsDTO = Data.define(:discovered_urls_count, :trained_urls_count, :id, :location_id, :status, :url, :mode, :knowledge_base_id, :created_at, :updated_at, :v, :robots_file_data)
    end
  end
end
