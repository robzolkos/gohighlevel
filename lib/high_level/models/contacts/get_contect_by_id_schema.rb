# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Contacts
      GetContectByIdSchema = Data.define(:id, :name, :location_id, :first_name, :last_name, :email, :email_lower_case, :timezone, :company_name, :phone, :dnd, :dnd_settings, :type, :source, :assigned_to, :address1, :city, :state, :country, :postal_code, :website, :tags, :date_of_birth, :date_added, :date_updated, :attachments, :ssn, :keyword, :first_name_lower_case, :full_name_lower_case, :last_name_lower_case, :last_activity, :custom_fields, :business_id, :attribution_source, :last_attribution_source, :visitor_id)
    end
  end
end
