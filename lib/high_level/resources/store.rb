# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/store.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Store < Base
      # List Shipping Zones
      #
      # The "List Shipping Zone" API allows to retrieve a list of shipping zone.
      def list_shipping_zones(alt_id: nil, alt_type: nil, limit: nil, offset: nil, with_shipping_rate: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-zone",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "limit" => limit, "offset" => offset, "withShippingRate" => with_shipping_rate }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create Shipping Zone
      #
      # The "Create Shipping Zone" API allows adding a new shipping zone.
      def create_shipping_zone(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/store/shipping-zone",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get Shipping Zone
      #
      # The "List Shipping Zone" API allows to retrieve a paginated list of shipping zone.
      def get_shipping_zones(shipping_zone_id:, alt_id: nil, alt_type: nil, with_shipping_rate: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-zone/#{shipping_zone_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "withShippingRate" => with_shipping_rate }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update Shipping Zone
      #
      # The "update Shipping Zone" API allows update a shipping zone to the system.
      def update_shipping_zone(shipping_zone_id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/store/shipping-zone/#{shipping_zone_id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Delete shipping zone
      #
      # Delete specific shipping zone with Id :shippingZoneId
      def delete_shipping_zone(shipping_zone_id:, alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/store/shipping-zone/#{shipping_zone_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get available shipping rates
      #
      # This return available shipping rates for country based on order amount
      def get_available_shipping_zones(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/store/shipping-zone/shipping-rates",
          security: [],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # List Shipping Rates
      #
      # The "List Shipping Rate" API allows to retrieve a list of shipping rate.
      def list_shipping_rates(shipping_zone_id:, alt_id: nil, alt_type: nil, limit: nil, offset: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-zone/#{shipping_zone_id}/shipping-rate",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type, "limit" => limit, "offset" => offset }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create Shipping Rate
      #
      # The "Create Shipping Rate" API allows adding a new shipping rate.
      def create_shipping_rate(shipping_zone_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/store/shipping-zone/#{shipping_zone_id}/shipping-rate",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get Shipping Rate
      #
      # The "List Shipping Rate" API allows to retrieve a paginated list of shipping rate.
      def get_shipping_rates(shipping_zone_id:, shipping_rate_id:, alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-zone/#{shipping_zone_id}/shipping-rate/#{shipping_rate_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update Shipping Rate
      #
      # The "update Shipping Rate" API allows update a shipping rate to the system.
      def update_shipping_rate(shipping_zone_id:, shipping_rate_id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/store/shipping-zone/#{shipping_zone_id}/shipping-rate/#{shipping_rate_id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Delete shipping rate
      #
      # Delete specific shipping rate with Id :shippingRateId
      def delete_shipping_rate(shipping_zone_id:, shipping_rate_id:, alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/store/shipping-zone/#{shipping_zone_id}/shipping-rate/#{shipping_rate_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # List Shipping Carriers
      #
      # The "List Shipping Carrier" API allows to retrieve a list of shipping carrier.
      def list_shipping_carriers(alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-carrier",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create Shipping Carrier
      #
      # The "Create Shipping Carrier" API allows adding a new shipping carrier.
      def create_shipping_carrier(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/store/shipping-carrier",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get Shipping Carrier
      #
      # The "List Shipping Carrier" API allows to retrieve a paginated list of shipping carrier.
      def get_shipping_carriers(shipping_carrier_id:, alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/shipping-carrier/#{shipping_carrier_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update Shipping Carrier
      #
      # The "update Shipping Carrier" API allows update a shipping carrier to the system.
      def update_shipping_carrier(shipping_carrier_id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/store/shipping-carrier/#{shipping_carrier_id}",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Delete shipping carrier
      #
      # Delete specific shipping carrier with Id :shippingCarrierId
      def delete_shipping_carrier(shipping_carrier_id:, alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :delete,
          path: "/store/shipping-carrier/#{shipping_carrier_id}",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get Store Settings
      #
      # Get store settings by altId and altType.
      def get_store_settings(alt_id: nil, alt_type: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/store/store-setting",
          security: ["Location-Access"],
          params: { "altId" => alt_id, "altType" => alt_type }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Create/Update Store Settings
      #
      # Create or update store settings by altId and altType.
      def create_store_setting(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/store/store-setting",
          security: ["Location-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end
    end
  end
end
