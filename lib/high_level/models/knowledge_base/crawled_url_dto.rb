# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module KnowledgeBase
      CrawledUrlDTO = Data.define(:id, :url, :title, :status, :location_id, :knowledge_base_id, :content, :content_edited_by_user, :updated_at)
    end
  end
end
