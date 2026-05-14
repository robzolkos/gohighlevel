# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/saas-api.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class SaasApi < Base
      # Get locations by stripeId with companyId
      #
      # Get locations by stripeCustomerId or stripeSubscriptionId with companyId
      def locations_deprecated(customer_id: nil, subscription_id: nil, company_id: nil, **_opts)
        request(
          method: :get,
          path: "/saas-api/public-api/locations",
          security: ["Agency-Access"],
          params: { "customerId" => customer_id, "subscriptionId" => subscription_id, "companyId" => company_id }.compact
        )
      end

      # Update SaaS subscription
      #
      # Update SaaS subscription for given locationId and customerId
      def update_saas_subscription_deprecated(location_id:, body:, **_opts)
        request(
          method: :put,
          path: "/saas-api/public-api/update-saas-subscription/#{location_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Disable SaaS for locations
      #
      # Disable SaaS for locations for given locationIds
      def bulk_disable_saas_deprecated(company_id:, body:, **_opts)
        request(
          method: :post,
          path: "/saas-api/public-api/bulk-disable-saas/#{company_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Enable SaaS for Sub-Account (Formerly Location)
      #
      # <div>
      #                   <p>Enable SaaS for Sub-Account (Formerly Location) based on the data provided</p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                           This feature is only available on Agency Pro ($497) plan.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      #
      def enable_saas_location_deprecated(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/saas-api/public-api/enable-saas/#{location_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Pause location
      #
      # Pause Sub account for given locationId
      def pause_location_deprecated(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/saas-api/public-api/pause/#{location_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Update Rebilling
      #
      # Bulk update rebilling for given locationIds
      def update_rebilling_deprecated(company_id:, body:, **_opts)
        request(
          method: :post,
          path: "/saas-api/public-api/update-rebilling/#{company_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Get Agency Plans
      #
      # Fetch all agency subscription plans for a given company ID
      def get_agency_plans_deprecated(company_id:, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas-api/public-api/agency-plans/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get Location Subscription Details
      #
      # Fetch subscription details for a specific location from location metadata
      def get_location_subscription_deprecated(location_id:, company_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas-api/public-api/get-saas-subscription/#{location_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Bulk Enable SaaS
      #
      # Enable SaaS mode for multiple locations with support for both SaaS v1 and v2
      def bulk_enable_saas_deprecated(company_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas-api/public-api/bulk-enable-saas/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get SaaS Locations
      #
      # Fetch all SaaS-activated locations for a company with pagination
      def get_saas_locations_deprecated(company_id:, page: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas-api/public-api/saas-locations/#{company_id}",
          security: ["Agency-Access"],
          params: { "page" => page }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get SaaS Plan
      #
      # Fetch a specific SaaS plan by plan ID
      def get_saas_plan_deprecated(plan_id:, company_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas-api/public-api/saas-plan/#{plan_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get locations by stripeId with companyId
      #
      # Get locations by stripeCustomerId or stripeSubscriptionId with companyId
      def locations(customer_id: nil, subscription_id: nil, company_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas/locations",
          security: ["Agency-Access"],
          params: { "customerId" => customer_id, "subscriptionId" => subscription_id, "companyId" => company_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Update SaaS subscription
      #
      # Update SaaS subscription for given locationId and customerId
      def generate_payment_link(location_id:, body:, authorization: nil, **_opts)
        request(
          method: :put,
          path: "/saas/update-saas-subscription/#{location_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Disable SaaS for locations
      #
      # Disable SaaS for locations for given locationIds
      def bulk_disable_saas(company_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas/bulk-disable-saas/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Enable SaaS for Sub-Account (Formerly Location)
      #
      # <div>
      #                   <p>Enable SaaS for Sub-Account (Formerly Location) based on the data provided</p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                           This feature is only available on Agency Pro ($497) plan.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      #
      def enable_saas_location(location_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas/enable-saas/#{location_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Pause location
      #
      # Pause Sub account for given locationId
      def pause_location(location_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas/pause/#{location_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Update Rebilling
      #
      # Bulk update rebilling for given locationIds
      def update_rebilling(company_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas/update-rebilling/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get Agency Plans
      #
      # Fetch all agency subscription plans for a given company ID
      def get_agency_plans(company_id:, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas/agency-plans/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get Location Subscription Details
      #
      # Fetch subscription details for a specific location from location metadata
      def get_location_subscription(location_id:, company_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas/get-saas-subscription/#{location_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Bulk Enable SaaS
      #
      # Enable SaaS mode for multiple locations with support for both SaaS v1 and v2
      def bulk_enable_saas(company_id:, body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/saas/bulk-enable-saas/#{company_id}",
          security: ["Agency-Access"],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # Get SaaS Locations
      #
      # Fetch all SaaS-activated locations for a company with pagination
      def get_saas_locations(company_id:, page: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas/saas-locations/#{company_id}",
          security: ["Agency-Access"],
          params: { "page" => page }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get SaaS Plan
      #
      # Fetch a specific SaaS plan by plan ID
      def get_saas_plan(plan_id:, company_id: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/saas/saas-plan/#{plan_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end
    end
  end
end
