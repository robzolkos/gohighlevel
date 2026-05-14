# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/phone-system.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class PhoneSystem < Base
      # List Number Pools
      #
      # Get list of number pools
      def get_number_pool_list(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/phone-system/number-pools",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact
        )
      end

      # List available phone numbers
      #
      # Search for available phone numbers to purchase for a specific location. Supports filtering by number pattern, type, and capabilities.
      def available_numbers(location_id:, country_code: nil, number_types: nil, first_part: nil, last_part: nil, anywhere: nil, sms_enabled: nil, mms_enabled: nil, voice_enabled: nil, **_opts)
        request(
          method: :get,
          path: "/phone-system/numbers/location/#{location_id}/available",
          security: ["Location-Access"],
          params: { "countryCode" => country_code, "numberTypes" => number_types, "firstPart" => first_part, "lastPart" => last_part, "anywhere" => anywhere, "smsEnabled" => sms_enabled, "mmsEnabled" => mms_enabled, "voiceEnabled" => voice_enabled }.compact
        )
      end

      # Purchase a phone number
      #
      # Purchase a phone number for a specific location.
      def purchase_phone_number(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/phone-system/numbers/location/#{location_id}/purchase",
          security: ["Location-Access"],
          body: body
        )
      end

      # List active numbers
      #
      # Retrieve a paginated list of active phone numbers for a specific location. Supports filtering, pagination, and optional exclusion of number pool assignments.
      def active_numbers(location_id:, page_size: nil, page: nil, search_filter: nil, skip_number_pool: nil, **_opts)
        request(
          method: :get,
          path: "/phone-system/numbers/location/#{location_id}",
          security: ["Location-Access"],
          params: { "pageSize" => page_size, "page" => page, "searchFilter" => search_filter, "skipNumberPool" => skip_number_pool }.compact
        )
      end
    end
  end
end
