# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Contacts
      UpdateContactDto = Data.define(:first_name, :last_name, :name, :email, :phone, :address1, :city, :state, :postal_code, :website, :timezone, :dnd, :dnd_settings, :inbound_dnd_settings, :tags, :custom_fields, :source, :date_of_birth, :country, :assigned_to)
    end
  end
end
