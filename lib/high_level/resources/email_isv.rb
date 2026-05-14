# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/email-isv.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class EmailIsv < Base
      # Email Verification
      #
      # Verify Email
      def verify_email(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/email/verify",
          security: ["Location-Access"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end
    end
  end
end
