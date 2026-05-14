# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/users.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Users
      PermissionsDto = Data.define(:campaigns_enabled, :campaigns_read_only, :contacts_enabled, :workflows_enabled, :workflows_read_only, :triggers_enabled, :funnels_enabled, :websites_enabled, :opportunities_enabled, :dashboard_stats_enabled, :bulk_requests_enabled, :appointments_enabled, :reviews_enabled, :online_listings_enabled, :phone_call_enabled, :conversations_enabled, :assigned_data_only, :adwords_reporting_enabled, :membership_enabled, :facebook_ads_reporting_enabled, :attributions_reporting_enabled, :settings_enabled, :tags_enabled, :lead_value_enabled, :marketing_enabled, :agent_reporting_enabled, :bot_service, :social_planner, :blogging_enabled, :invoice_enabled, :affiliate_manager_enabled, :content_ai_enabled, :refunds_enabled, :record_payment_enabled, :cancel_subscription_enabled, :payments_enabled, :communities_enabled, :export_payments_enabled)
    end
  end
end
