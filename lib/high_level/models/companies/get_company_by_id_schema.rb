# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/companies.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Companies
      GetCompanyByIdSchema = Data.define(:id, :name, :email, :logo_url, :phone, :website, :domain, :spare_domain, :privacy_policy, :terms_conditions, :address, :city, :postal_code, :country, :state, :timezone, :relationship_number, :subdomain, :plan, :currency, :customer_type, :terms_of_service_version, :terms_of_service_accepted_by, :twilio_trial_mode, :twilio_free_credits, :terms_of_service_accepted_date, :privacy_policy_version, :privacy_policy_accepted_by, :privacy_policy_accepted_date, :affiliate_policy_version, :affiliate_policy_accepted_by, :affiliate_policy_accepted_date, :is_reselling, :onboarding_info, :upgrade_enabled_for_clients, :cancel_enabled_for_clients, :auto_suspend_enabled, :saas_settings, :stripe_connect_id, :enable_depreciated_features, :premium_upgraded, :status, :location_count, :disable_email_service, :referral_id, :is_enterprise_account, :business_niche, :business_category, :business_affinity_group, :is_sandbox_account, :enable_new_sub_account_default_data)
    end
  end
end
