# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/funnels.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Funnels < Base
      # Create Redirect
      #
      # The "Create Redirect" API Allows adding a new url redirect to the system. Use this endpoint to create a url redirect with the specified details. Ensure that the required information is provided in the request payload.
      def create_redirect(body:, **_opts)
        request(
          method: :post,
          path: "/funnels/lookup/redirect",
          security: ["Location-Access"],
          body: body
        )
      end

      # Update Redirect By Id
      #
      # The "Update Redirect By Id" API Allows updating an existing URL redirect in the system. Use this endpoint to modify a URL redirect with the specified ID using details provided in the request payload.
      def update_redirect_by_id(id:, body:, **_opts)
        request(
          method: :patch,
          path: "/funnels/lookup/redirect/#{id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete Redirect By Id
      #
      # The "Delete Redirect By Id" API Allows deletion of a URL redirect from the system using its unique identifier. Use this endpoint to delete a URL redirect with the specified ID using details provided in the request payload.
      def delete_redirect_by_id(id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/funnels/lookup/redirect/#{id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Fetch List of Redirects
      #
      # Retrieves a list of all URL redirects based on the given query parameters.
      def fetch_redirects_list(location_id: nil, limit: nil, offset: nil, search: nil, **_opts)
        request(
          method: :get,
          path: "/funnels/lookup/redirect/list",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset, "search" => search }.compact
        )
      end

      # Fetch List of Funnels
      #
      # Retrieves a list of all funnels based on the given query parameters.
      def get_funnels(location_id: nil, type: nil, category: nil, offset: nil, limit: nil, parent_id: nil, name: nil, **_opts)
        request(
          method: :get,
          path: "/funnels/funnel/list",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "type" => type, "category" => category, "offset" => offset, "limit" => limit, "parentId" => parent_id, "name" => name }.compact
        )
      end

      # Fetch list of funnel pages
      #
      # Retrieves a list of all funnel pages based on the given query parameters.
      def get_pages_by_funnel_id(location_id: nil, funnel_id: nil, name: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/funnels/page",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "funnelId" => funnel_id, "name" => name, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Fetch count of funnel pages
      #
      # Retrieves count of all funnel pages based on the given query parameters.
      def get_pages_count_by_funnel_id(location_id: nil, funnel_id: nil, name: nil, **_opts)
        request(
          method: :get,
          path: "/funnels/page/count",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "funnelId" => funnel_id, "name" => name }.compact
        )
      end
    end
  end
end
