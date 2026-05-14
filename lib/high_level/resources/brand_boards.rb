# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/brand-boards.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class BrandBoards < Base
      # Get Brand Boards
      #
      # Retrieves all Brand Boards for a specific location
      def get_brand_boards_by_location(location_id:, limit: nil, offset: nil, search: nil, deleted: nil, **_opts)
        request(
          method: :get,
          path: "/brand-boards/#{location_id}",
          security: ["Location-Access"],
          params: { "limit" => limit, "offset" => offset, "search" => search, "deleted" => deleted }.compact
        )
      end

      # Get Brand Board
      #
      # Retrieves a specific Brand Board by its ID
      def get_brand_board_by_id(location_id:, id:, **_opts)
        request(
          method: :get,
          path: "/brand-boards/#{location_id}/#{id}",
          security: ["Location-Access"]
        )
      end

      # Update a Brand Board
      #
      # Updates an existing Brand Board
      def update_brand_board(location_id:, id:, body:, **_opts)
        request(
          method: :patch,
          path: "/brand-boards/#{location_id}/#{id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete a Brand Board
      #
      # Deletes a Brand Board
      def delete_brand_board(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/brand-boards/#{location_id}/#{id}",
          security: ["Location-Access"]
        )
      end

      # Create a new brand board
      #
      # Creates a new brand board with logos, colors, and fonts
      def create_brand_board(body:, **_opts)
        request(
          method: :post,
          path: "/brand-boards/",
          security: ["Location-Access"],
          body: body
        )
      end
    end
  end
end
