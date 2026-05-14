# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/workflows.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Workflows < Base
      # Get Workflow
      def get_workflow(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/workflows/",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end
    end
  end
end
