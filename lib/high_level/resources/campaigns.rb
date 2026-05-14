# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/campaigns.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Campaigns < Base
      # Get Campaigns
      def get_campaigns(location_id: nil, status: nil, **_opts)
        request(
          method: :get,
          path: "/campaigns/",
          security: ["bearer"],
          params: { "locationId" => location_id, "status" => status }.compact
        )
      end
    end
  end
end
