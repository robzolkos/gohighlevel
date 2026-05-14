# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/users.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Users
      UpdateUserDto = Data.define(:first_name, :last_name, :email, :password, :phone, :type, :role, :company_id, :location_ids, :permissions, :scopes, :scopes_assigned_to_only, :profile_photo, :twilio_phone, :platform_language)
    end
  end
end
