# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/businesses.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Businesses < Base
      # Get Business
      def get_business(business_id:, **_opts)
        request(
          method: :get,
          path: "/businesses/#{business_id}",
          security: ["bearer"]
        )
      end

      # Update Business
      def update_business(business_id:, body:, **_opts)
        request(
          method: :put,
          path: "/businesses/#{business_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Business
      def delete_business(business_id:, **_opts)
        request(
          method: :delete,
          path: "/businesses/#{business_id}",
          security: ["bearer"]
        )
      end

      # Get Businesses by Location
      def get_businesses_by_location(location_id: nil, limit: nil, skip: nil, **_opts)
        request(
          method: :get,
          path: "/businesses/",
          security: ["bearer"],
          params: { "locationId" => location_id, "limit" => limit, "skip" => skip }.compact
        )
      end

      # Create Business
      def create_business(body:, **_opts)
        request(
          method: :post,
          path: "/businesses/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
