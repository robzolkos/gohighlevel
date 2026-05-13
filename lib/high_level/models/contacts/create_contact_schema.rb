# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Contacts
      CreateContactSchema = Data.define(:id, :date_added, :date_updated, :deleted, :tags, :type, :custom_fields, :location_id, :first_name, :first_name_lower_case, :full_name_lower_case, :last_name, :last_name_lower_case, :email, :email_lower_case, :bounce_email, :unsubscribe_email, :dnd, :dnd_settings, :phone, :address1, :city, :state, :country, :postal_code, :website, :source, :company_name, :date_of_birth, :birth_month, :birth_day, :last_session_activity_at, :offers, :products, :business_id, :assigned_to)
    end
  end
end
