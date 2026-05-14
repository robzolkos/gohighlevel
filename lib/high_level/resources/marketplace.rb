# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/marketplace.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Marketplace < Base
      # Get all wallet charges
      def get_charges(meter_id: nil, event_id: nil, user_id: nil, start_date: nil, end_date: nil, skip: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/marketplace/billing/charges",
          security: ["Location-Access-Only"],
          params: { "meterId" => meter_id, "eventId" => event_id, "userId" => user_id, "startDate" => start_date, "endDate" => end_date, "skip" => skip, "limit" => limit }.compact
        )
      end

      # Create a new wallet charge
      def charge(body:, **_opts)
        request(
          method: :post,
          path: "/marketplace/billing/charges",
          security: ["Location-Access-Only"],
          body: body
        )
      end

      # Get specific wallet charge details
      def get_specific_charge(charge_id:, **_opts)
        request(
          method: :get,
          path: "/marketplace/billing/charges/#{charge_id}",
          security: ["Location-Access-Only"]
        )
      end

      # Delete a wallet charge
      def delete_charge(charge_id:, **_opts)
        request(
          method: :delete,
          path: "/marketplace/billing/charges/#{charge_id}",
          security: ["Location-Access-Only"]
        )
      end

      # Check if account has sufficient funds
      def has_funds(**_opts)
        request(
          method: :get,
          path: "/marketplace/billing/charges/has-funds",
          security: ["Location-Access-Only"]
        )
      end

      # Get Installer Details
      #
      # Fetches installer details for the authenticated user. This endpoint returns information about the company, location, user, and installation details associated with the current OAuth token.
      def get_installer_details(app_id:, **_opts)
        request(
          method: :get,
          path: "/marketplace/app/#{app_id}/installations",
          security: %w[Location-Access-Only Agency-Access-Only]
        )
      end

      # Uninstall an application
      #
      # Uninstalls an application from your company or a specific location. This will remove the application`s access and stop all its functionalities
      def uninstall_application(app_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/marketplace/app/#{app_id}/installations",
          security: %w[Location-Access-Only Agency-Access],
          body: body
        )
      end

      # Get rebilling config for an app subscription and usage plans
      #
      # Get rebilling config for an app subscription and usage plans for the authenticated sub-account. This endpoint returns the subscription and usage plans for an app.
      def get_rebilling_config_for_app(app_id:, location_id:, **_opts)
        request(
          method: :get,
          path: "/marketplace/app/#{app_id}/rebilling-config/location/#{location_id}",
          security: ["Location-Access-Only"]
        )
      end

      # Migrate external authentication connection
      #
      # Migrates an external authentication connection credentials (basic or oauth2) for a specific app and location. This endpoint validates the app configuration, stores credentials safely in CRM's native encrypted storage. With this the lifecycle of the token is managed by CRM.
      def migrate_connection(body:, **_opts)
        request(
          method: :post,
          path: "/marketplace/external-auth/migration",
          security: %w[Location-Access Location-Access-Only],
          body: body
        )
      end
    end
  end
end
