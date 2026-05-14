# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/knowledge-base.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class KnowledgeBase < Base
      # Get all FAQs by knowledge base with pagination support
      #
      # Retrieves FAQs for a knowledge base. Supports pagination using limit and lastFaqId parameters.
      def list(knowledge_base_id: nil, location_id: nil, limit: nil, last_faq_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/knowledge-bases/faqs",
          security: ["Location-Access"],
          params: { "knowledgeBaseId" => knowledge_base_id, "locationId" => location_id, "limit" => limit, "lastFaqId" => last_faq_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create a new FAQ inside knowledge base
      def create(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/knowledge-bases/faqs",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Update an existing knowledge base FAQ
      def update(id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/knowledge-bases/faqs/#{id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Delete an existing knowledge base FAQ
      def delete(id:, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/knowledge-bases/faqs/#{id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get all trained page links by knowledge base
      def get_all_website_urls_data_by_knowledge_base(knowledge_base_id: nil, location_id: nil, page: nil, page_length: nil, query: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/knowledge-bases/crawler",
          security: ["Location-Access"],
          params: { "knowledgeBaseId" => knowledge_base_id, "locationId" => location_id, "page" => page, "pageLength" => page_length, "query" => query }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Start crawling and discover pages for training
      def discover_website(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/knowledge-bases/crawler",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Delete trained pages
      def delete_trained_urls_for_knowledge_base(body:, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/knowledge-bases/crawler",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get crawling status for the latest operation
      def get_crawling_status_for_latest_operation(location_id: nil, operation_id: nil, knowledge_base_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/knowledge-bases/crawler/status",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "operationId" => operation_id, "knowledgeBaseId" => knowledge_base_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Train discovered website pages and ingest into the knowledge base
      def train_discovered_urls(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/knowledge-bases/crawler/train",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get knowledge base by ID
      def get_knowledge_base_by_id(knowledge_base_id:, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/knowledge-bases/#{knowledge_base_id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Delete a knowledge base
      def delete_knowledge_base(knowledge_base_id:, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/knowledge-bases/#{knowledge_base_id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update a knowledge base
      def update_knowledge_base(id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/knowledge-bases/#{id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get all knowledge bases for a location by location Id (paginated)
      def list_all_knowledge_bases_paginated(location_id: nil, query: nil, limit: nil, last_knowledge_base_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/knowledge-bases/",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "query" => query, "limit" => limit, "lastKnowledgeBaseId" => last_knowledge_base_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create a new knowledge base (max 15 knowledge bases per location)
      def create_knowledge_base(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/knowledge-bases/",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end
    end
  end
end
