# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/users.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Users
      UserSuccessfulResponseDto = Data.define(:id, :name, :first_name, :last_name, :email, :phone, :extension, :permissions, :scopes, :roles, :lc_phone, :platform_language)
    end
  end
end
