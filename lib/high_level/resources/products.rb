# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/products.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Products < Base
      # Bulk Update Products
      #
      # API to bulk update products (price, availability, collections, delete)
      def bulk_update(body:, **_opts)
        request(
          method: :post,
          path: "/products/bulk-update",
          security: ["Location-Access"],
          body: body
        )
      end

      # Bulk Edit Products and Prices
      #
      # API to bulk edit products and their associated prices (max 30 entities)
      def bulk_edit(body:, **_opts)
        request(
          method: :post,
          path: "/products/bulk-update/edit",
          security: [],
          body: body
        )
      end

      # List Prices for a Product
      #
      # The "List Prices for a Product" API allows retrieving a paginated list of prices associated with a specific product. Customize your results by filtering prices or paginate through the list using the provided query parameters.
      def list_prices_for_product(product_id:, limit: nil, offset: nil, location_id: nil, ids: nil, **_opts)
        request(
          method: :get,
          path: "/products/#{product_id}/price",
          security: %w[Location-Access Agency-Access],
          params: { "limit" => limit, "offset" => offset, "locationId" => location_id, "ids" => ids }.compact
        )
      end

      # Create Price for a Product
      #
      # The "Create Price for a Product" API allows adding a new price associated with a specific product to the system. Use this endpoint to create a price with the specified details for a particular product. Ensure that the required information is provided in the request payload.
      def create_price_for_product(product_id:, body:, **_opts)
        request(
          method: :post,
          path: "/products/#{product_id}/price",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # List Inventory
      #
      # The "List Inventory API allows the user to retrieve a paginated list of inventory items. Use this endpoint to fetch details for multiple items in the inventory based on the provided query parameters.
      def get_list_inventory(limit: nil, offset: nil, alt_id: nil, alt_type: nil, search: nil, **_opts)
        request(
          method: :get,
          path: "/products/inventory",
          security: %w[Location-Access Agency-Access],
          params: { "limit" => limit, "offset" => offset, "altId" => alt_id, "altType" => alt_type, "search" => search }.compact
        )
      end

      # Update Inventory
      #
      # The Update Inventory API allows the user to bulk update the inventory for multiple items. Use this endpoint to update the available quantity and out-of-stock purchase settings for multiple items in the inventory.
      def update_inventory(body:, **_opts)
        request(
          method: :post,
          path: "/products/inventory",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Get Price by ID for a Product
      #
      # The "Get Price by ID for a Product" API allows retrieving information for a specific price associated with a particular product using its unique identifier. Use this endpoint to fetch details for a single price based on the provided price ID and product ID.
      def get_price_by_id_for_product(product_id:, price_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/products/#{product_id}/price/#{price_id}",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id }.compact
        )
      end

      # Update Price by ID for a Product
      #
      # The "Update Price by ID for a Product" API allows modifying information for a specific price associated with a particular product using its unique identifier. Use this endpoint to update details for a single price based on the provided price ID and product ID.
      def update_price_by_id_for_product(product_id:, price_id:, body:, **_opts)
        request(
          method: :put,
          path: "/products/#{product_id}/price/#{price_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete Price by ID for a Product
      #
      # The "Delete Price by ID for a Product" API allows deleting a specific price associated with a particular product using its unique identifier. Use this endpoint to remove a price from the system.
      def delete_price_by_id_for_product(product_id:, price_id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/products/#{product_id}/price/#{price_id}",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id }.compact
        )
      end

      # Fetch Product Store Stats
      #
      # API to fetch the total number of products, included in the store, and excluded from the store and other stats
      def get_product_store_stats(store_id:, alt_id: nil, alt_type: nil, search: nil, collection_ids: nil, **_opts)
        request(
          method: :get,
          path: "/products/store/#{store_id}/stats",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "search" => search, "collectionIds" => collection_ids }.compact
        )
      end

      # Action to include/exclude the product in store
      #
      # API to update the status of products in a particular store
      def update_store_status(store_id:, body:, **_opts)
        request(
          method: :post,
          path: "/products/store/#{store_id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Update product display priorities in store
      #
      # API to set the display priority of products in a store
      def update_display_priority(store_id:, body:, **_opts)
        request(
          method: :post,
          path: "/products/store/#{store_id}/priority",
          security: ["Location-Access"],
          body: body
        )
      end

      # Fetch Product Collections
      #
      # Internal API to fetch the Product Collections
      def get_product_collection(limit: nil, offset: nil, alt_id: nil, alt_type: nil, collection_ids: nil, name: nil, **_opts)
        request(
          method: :get,
          path: "/products/collections",
          security: ["Location-Access"],
          params: { "limit" => limit, "offset" => offset, "altId" => alt_id, "altType" => alt_type, "collectionIds" => collection_ids, "name" => name }.compact
        )
      end

      # Create Product Collection
      #
      # Create a new Product Collection for a specific location
      def create_product_collection(body:, **_opts)
        request(
          method: :post,
          path: "/products/collections",
          security: ["Location-Access"],
          body: body
        )
      end

      # Get Details about individual product collection
      def get_product_collection_id(collection_id:, alt_id: nil, **_opts)
        request(
          method: :get,
          path: "/products/collections/#{collection_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id }.compact
        )
      end

      # Update Product Collection
      #
      # Update a specific product collection with Id :collectionId
      def update_product_collection(collection_id:, body:, **_opts)
        request(
          method: :put,
          path: "/products/collections/#{collection_id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete Product Collection
      #
      # Delete specific product collection with Id :collectionId
      def delete_product_collection(collection_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :delete,
          path: "/products/collections/#{collection_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Fetch Product Reviews
      #
      # API to fetch the Product Reviews
      def get_product_reviews(alt_id: nil, alt_type: nil, limit: nil, offset: nil, sort_field: nil, sort_order: nil, rating: nil, start_date: nil, end_date: nil, product_id: nil, store_id: nil, **_opts)
        request(
          method: :get,
          path: "/products/reviews",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "limit" => limit, "offset" => offset, "sortField" => sort_field, "sortOrder" => sort_order, "rating" => rating, "startDate" => start_date, "endDate" => end_date, "productId" => product_id, "storeId" => store_id }.compact
        )
      end

      # Fetch Review Count as per status
      #
      # API to fetch the Review Count as per status
      def get_reviews_count(alt_id: nil, alt_type: nil, rating: nil, start_date: nil, end_date: nil, product_id: nil, store_id: nil, **_opts)
        request(
          method: :get,
          path: "/products/reviews/count",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "rating" => rating, "startDate" => start_date, "endDate" => end_date, "productId" => product_id, "storeId" => store_id }.compact
        )
      end

      # Update Product Reviews
      #
      # Update status, reply, etc of a particular review
      def update_product_review(review_id:, body:, **_opts)
        request(
          method: :put,
          path: "/products/reviews/#{review_id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete Product Review
      #
      # Delete specific product review
      def delete_product_review(review_id:, alt_id: nil, alt_type: nil, product_id: nil, **_opts)
        request(
          method: :delete,
          path: "/products/reviews/#{review_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "productId" => product_id }.compact
        )
      end

      # Update Product Reviews
      #
      # Update one or multiple product reviews: status, reply, etc.
      def bulk_update_product_review(body:, **_opts)
        request(
          method: :post,
          path: "/products/reviews/bulk-update",
          security: ["Location-Access"],
          body: body
        )
      end

      # Get Product by ID
      #
      # The "Get Product by ID" API allows to retrieve information for a specific product using its unique identifier. Use this endpoint to fetch details for a single product based on the provided product ID.
      def get_product_by_id(product_id:, location_id: nil, send_wishlist_status: nil, **_opts)
        request(
          method: :get,
          path: "/products/#{product_id}",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id, "sendWishlistStatus" => send_wishlist_status }.compact
        )
      end

      # Update Product by ID
      #
      # The "Update Product by ID" API allows modifying information for a specific product using its unique identifier. Use this endpoint to update details for a single product based on the provided product ID.
      def update_product_by_id(product_id:, body:, **_opts)
        request(
          method: :put,
          path: "/products/#{product_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete Product by ID
      #
      # The "Delete Product by ID" API allows deleting a specific product using its unique identifier. Use this endpoint to remove a product from the system.
      def delete_product_by_id(product_id:, location_id: nil, send_wishlist_status: nil, **_opts)
        request(
          method: :delete,
          path: "/products/#{product_id}",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id, "sendWishlistStatus" => send_wishlist_status }.compact
        )
      end

      # List Products
      #
      # The "List Products" API allows to retrieve a paginated list of products. Customize your results by filtering products based on name or paginate through the list using the provided query parameters. This endpoint provides a straightforward way to explore and retrieve product information.
      def list_invoices(limit: nil, offset: nil, location_id: nil, search: nil, collection_ids: nil, collection_slug: nil, expand: nil, product_ids: nil, store_id: nil, included_in_store: nil, available_in_store: nil, sort_order: nil, **_opts)
        request(
          method: :get,
          path: "/products/",
          security: %w[Location-Access Agency-Access],
          params: { "limit" => limit, "offset" => offset, "locationId" => location_id, "search" => search, "collectionIds" => collection_ids, "collectionSlug" => collection_slug, "expand" => expand, "productIds" => product_ids, "storeId" => store_id, "includedInStore" => included_in_store, "availableInStore" => available_in_store, "sortOrder" => sort_order }.compact
        )
      end

      # Create Product
      #
      # The "Create Product" API allows adding a new product to the system. Use this endpoint to create a product with the specified details. Ensure that the required information is provided in the request payload.
      def create_product(body:, **_opts)
        request(
          method: :post,
          path: "/products/",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end
    end
  end
end
