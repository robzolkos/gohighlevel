# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/links.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Links < Base
      # Get Link by ID
      #
      # Get a single link by its ID
      def get_link_by_id(link_id:, location_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/links/id/#{link_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update Link
      def update_link(link_id:, body:, **_opts)
        request(
          method: :put,
          path: "/links/#{link_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Link
      def delete_link(link_id:, **_opts)
        request(
          method: :delete,
          path: "/links/#{link_id}",
          security: ["bearer"]
        )
      end

      # Search Trigger Links
      #
      # Get list of links by searching
      def search_trigger_links(location_id: nil, query: nil, skip: nil, limit: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/links/search",
          security: ["bearer"],
          params: { "locationId" => location_id, "query" => query, "skip" => skip, "limit" => limit }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get Links
      def get_links(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/links/",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Link
      def create_link(body:, **_opts)
        request(
          method: :post,
          path: "/links/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
