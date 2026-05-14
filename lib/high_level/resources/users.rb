# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/users.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Users < Base
      # Search Users
      def search_users(company_id: nil, query: nil, skip: nil, limit: nil, location_id: nil, type: nil, role: nil, ids: nil, sort: nil, sort_direction: nil, enabled2way_sync: nil, **_opts)
        request(
          method: :get,
          path: "/users/search",
          security: %w[Agency-Access Location-Access],
          params: { "companyId" => company_id, "query" => query, "skip" => skip, "limit" => limit, "locationId" => location_id, "type" => type, "role" => role, "ids" => ids, "sort" => sort, "sortDirection" => sort_direction, "enabled2waySync" => enabled2way_sync }.compact
        )
      end

      # Filter Users by Email
      #
      # Filter users by company ID, deleted status, and email array
      def filter_users_by_email(body:, **_opts)
        request(
          method: :post,
          path: "/users/search/filter-by-email",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Get User
      def get_user(user_id:, **_opts)
        request(
          method: :get,
          path: "/users/#{user_id}",
          security: %w[Agency-Access Location-Access]
        )
      end

      # Update User
      def update_user(body:, **_opts)
        request(
          method: :put,
          path: "/users/#{user_id}",
          security: %w[Agency-Access Location-Access],
          body: body
        )
      end

      # Delete User
      def delete_user(**_opts)
        request(
          method: :delete,
          path: "/users/#{user_id}",
          security: %w[Agency-Access Location-Access]
        )
      end

      # Get User by Location
      #
      # Deprecated. Use `GET /users/search` instead. Pass `locationId` as a query parameter to filter results by location, along with the required `companyId` and other search filters as needed.
      def get_user_by_location(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/users/",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create User
      def create_user(body:, **_opts)
        request(
          method: :post,
          path: "/users/",
          security: %w[Agency-Access Location-Access],
          body: body
        )
      end
    end
  end
end
