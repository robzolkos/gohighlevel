# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/payments.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Payments < Base
      # List White-label Integration Providers
      #
      # The "List White-label Integration Providers" API allows to retrieve a paginated list of integration providers. Customize your results by filtering whitelabel integration providers(which are built directly on top of Authorize.net or NMI) based on name or paginate through the list using the provided query parameters. This endpoint provides a straightforward way to explore and retrieve integration provider information.
      def list_integration_providers(alt_id: nil, alt_type: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/payments/integrations/provider/whitelabel",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Create White-label Integration Provider
      #
      # The "Create White-label Integration Provider" API allows adding a new payment provider integration to the system which is built on top of Authorize.net or NMI. Use this endpoint to create a integration provider with the specified details. Ensure that the required information is provided in the request payload. This endpoint can be only invoked using marketplace-app token
      def create_integration_provider(body:, **_opts)
        request(
          method: :post,
          path: "/payments/integrations/provider/whitelabel",
          security: ["Location-Access"],
          body: body
        )
      end

      # List Orders
      #
      # The "List Orders" API allows to retrieve a paginated list of orders. Customize your results by filtering orders based on name, alt type, order status, payment mode, date range, type of source, contact, funnel products or paginate through the list using the provided query parameters. This endpoint provides a straightforward way to explore and retrieve order information.
      def list_orders(location_id: nil, alt_id: nil, status: nil, payment_status: nil, payment_mode: nil, start_at: nil, end_at: nil, search: nil, contact_id: nil, funnel_product_ids: nil, source_id: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/payments/orders",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "altId" => alt_id, "status" => status, "paymentStatus" => payment_status, "paymentMode" => payment_mode, "startAt" => start_at, "endAt" => end_at, "search" => search, "contactId" => contact_id, "funnelProductIds" => funnel_product_ids, "sourceId" => source_id, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Get Order by ID
      #
      # The "Get Order by ID" API allows to retrieve information for a specific order using its unique identifier. Use this endpoint to fetch details for a single order based on the provided order ID.
      def get_order_by_id(order_id:, location_id: nil, alt_id: nil, **_opts)
        request(
          method: :get,
          path: "/payments/orders/#{order_id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "altId" => alt_id }.compact
        )
      end

      # Record Order Payment
      #
      # The "Record Order Payment" API allows to record a payment for an order. Use this endpoint to record payment for an order and update the order status to "Paid".
      def record_order_payment(order_id:, body:, **_opts)
        request(
          method: :post,
          path: "/payments/orders/#{order_id}/record-payment",
          security: ["Location-Access"],
          body: body
        )
      end

      # List fulfillment
      #
      # List all fulfillment history of an order
      def list_order_fulfillment(order_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/payments/orders/#{order_id}/fulfillments",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Create order fulfillment
      #
      # The "Order Fulfillment" API facilitates the process of fulfilling an order.
      def create_order_fulfillment(order_id:, body:, **_opts)
        request(
          method: :post,
          path: "/payments/orders/#{order_id}/fulfillments",
          security: ["Location-Access"],
          body: body
        )
      end

      # List Order Notes
      #
      # List all notes of an order
      def list_order_notes(order_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/payments/orders/#{order_id}/notes",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # List Transactions
      #
      # The "List Transactions" API allows to retrieve a paginated list of transactions. Customize your results by filtering transactions based on name, alt type, transaction status, payment mode, date range, type of source, contact, subscription id, entity id or paginate through the list using the provided query parameters. This endpoint provides a straightforward way to explore and retrieve transaction information.
      def list_transactions(location_id: nil, alt_id: nil, alt_type: nil, payment_mode: nil, start_at: nil, end_at: nil, entity_source_type: nil, entity_source_sub_type: nil, search: nil, subscription_id: nil, entity_id: nil, contact_id: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/payments/transactions",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "altId" => alt_id, "altType" => alt_type, "paymentMode" => payment_mode, "startAt" => start_at, "endAt" => end_at, "entitySourceType" => entity_source_type, "entitySourceSubType" => entity_source_sub_type, "search" => search, "subscriptionId" => subscription_id, "entityId" => entity_id, "contactId" => contact_id, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Get Transaction by ID
      #
      # The "Get Transaction by ID" API allows to retrieve information for a specific transaction using its unique identifier. Use this endpoint to fetch details for a single transaction based on the provided transaction ID.
      def get_transaction_by_id(transaction_id:, location_id: nil, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/payments/transactions/#{transaction_id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # List Subscriptions
      #
      # The "List Subscriptions" API allows to retrieve a paginated list of subscriptions. Customize your results by filtering subscriptions based on name, alt type, subscription status, payment mode, date range, type of source, contact, subscription id, entity id, contact or paginate through the list using the provided query parameters. This endpoint provides a straightforward way to explore and retrieve subscription information.
      def list_subscriptions(alt_id: nil, alt_type: nil, entity_id: nil, payment_mode: nil, start_at: nil, end_at: nil, entity_source_type: nil, search: nil, contact_id: nil, id: nil, limit: nil, offset: nil, get_payments_collected_count: nil, **_opts)
        request(
          method: :get,
          path: "/payments/subscriptions",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "entityId" => entity_id, "paymentMode" => payment_mode, "startAt" => start_at, "endAt" => end_at, "entitySourceType" => entity_source_type, "search" => search, "contactId" => contact_id, "id" => id, "limit" => limit, "offset" => offset, "getPaymentsCollectedCount" => get_payments_collected_count }.compact
        )
      end

      # Get Subscription by ID
      #
      # The "Get Subscription by ID" API allows to retrieve information for a specific subscription using its unique identifier. Use this endpoint to fetch details for a single subscription based on the provided subscription ID.
      def get_subscription_by_id(subscription_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/payments/subscriptions/#{subscription_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # List Coupons
      #
      # The "List Coupons" API allows you to retrieve a list of all coupons available in your location. Use this endpoint to view all promotional offers and special discounts for your customers.
      def list_coupons(alt_id: nil, alt_type: nil, limit: nil, offset: nil, status: nil, search: nil, **_opts)
        request(
          method: :get,
          path: "/payments/coupon/list",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "limit" => limit, "offset" => offset, "status" => status, "search" => search }.compact
        )
      end

      # Fetch Coupon
      #
      # The "Get Coupon Details" API enables you to retrieve comprehensive information about a specific coupon using either its unique identifier or promotional code. Use this endpoint to view coupon parameters, usage statistics, validity periods, and other promotional details.
      def get_coupon(alt_id: nil, alt_type: nil, id: nil, code: nil, **_opts)
        request(
          method: :get,
          path: "/payments/coupon",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "id" => id, "code" => code }.compact
        )
      end

      # Create Coupon
      #
      # The "Create Coupon" API allows you to create a new promotional coupon with customizable parameters such as discount amount, validity period, usage limits, and applicable products. Use this endpoint to set up promotional offers and special discounts for your customers.
      def create_coupon(body:, **_opts)
        request(
          method: :post,
          path: "/payments/coupon",
          security: ["Location-Access"],
          body: body
        )
      end

      # Update Coupon
      #
      # The "Update Coupon" API enables you to modify existing coupon details such as discount values, validity periods, usage limits, and other promotional parameters. Use this endpoint to adjust or extend promotional offers for your customers.
      def update_coupon(body:, **_opts)
        request(
          method: :put,
          path: "/payments/coupon",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete Coupon
      #
      # The "Delete Coupon" API allows you to permanently remove a coupon from your system using its unique identifier. Use this endpoint to discontinue promotional offers or clean up unused coupons. Note that this action cannot be undone.
      def delete_coupon(body:, **_opts)
        request(
          method: :delete,
          path: "/payments/coupon",
          security: ["Location-Access"],
          body: body
        )
      end

      # Create new integration
      #
      # API to create a new association for an app and location
      def create_integration(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/payments/custom-provider/provider",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Deleting an existing integration
      #
      # API to delete an association for an app and location
      def delete_integration(location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/payments/custom-provider/provider",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Fetch given provider config
      #
      # API for fetching an existing payment config for given location
      def fetch_config(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/payments/custom-provider/connect",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create new provider config
      #
      # API to create a new payment config for given location
      def create_config(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/payments/custom-provider/connect",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Disconnect existing provider config
      #
      # API to disconnect an existing payment config for given location
      def disconnect_config(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/payments/custom-provider/disconnect",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Custom-provider marketplace app update capabilities
      #
      # Toggle capabilities for the marketplace app tied to the OAuth client
      def custom_provider_marketplace_app_update_capabilities(body:, **_opts)
        request(
          method: :put,
          path: "/payments/custom-provider/capabilities",
          security: ["Location-Access"],
          body: body
        )
      end
    end
  end
end
