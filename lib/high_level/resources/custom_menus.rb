# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/custom-menus.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class CustomMenus < Base
      # Get Custom Menu Link
      #
      # Fetches a single custom menus based on id. This endpoint allows clients to retrieve custom menu configurations, which may include menu items, categories, and associated metadata
      def get_custom_menu_by_id(custom_menu_id:, **_opts)
        request(
          method: :get,
          path: "/custom-menus/#{custom_menu_id}",
          security: ["Agency-Access"]
        )
      end

      # Update Custom Menu Link
      #
      # Updates an existing custom menu for a given company. Requires authentication and proper permissions.
      def update_custom_menu(custom_menu_id:, body:, **_opts)
        request(
          method: :put,
          path: "/custom-menus/#{custom_menu_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Delete Custom Menu Link
      #
      # Removes a specific custom menu from the system. This operation requires authentication and proper permissions. The custom menu is identified by its unique ID, and the operation is performed within the context of a specific company.
      def delete_custom_menu(custom_menu_id:, **_opts)
        request(
          method: :delete,
          path: "/custom-menus/#{custom_menu_id}",
          security: ["Agency-Access"]
        )
      end

      # Get Custom Menu Links
      #
      # Fetches a collection of custom menus based on specified criteria. This endpoint allows clients to retrieve custom menu configurations, which may include menu items, categories, and associated metadata. The response can be tailored using query parameters for filtering, sorting, and pagination.
      def get_custom_menus(location_id: nil, skip: nil, limit: nil, query: nil, show_on_company: nil, **_opts)
        request(
          method: :get,
          path: "/custom-menus/",
          security: ["Agency-Access"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit, "query" => query, "showOnCompany" => show_on_company }.compact
        )
      end

      # Create Custom Menu Link
      #
      # Creates a new custom menu for a company. Requires authentication and proper permissions. For Icon Usage Details please refer to  https://doc.clickup.com/8631005/d/h/87cpx-243696/d60fa70db6b92b2
      def create_custom_menu(body:, **_opts)
        request(
          method: :post,
          path: "/custom-menus/",
          security: ["Agency-Access"],
          body: body
        )
      end
    end
  end
end
