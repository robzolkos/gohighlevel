# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/store.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Store
      StoreOrderNotificationDto = Data.define(:enabled, :subject, :email_template_id, :default_email_template_id)
    end
  end
end
