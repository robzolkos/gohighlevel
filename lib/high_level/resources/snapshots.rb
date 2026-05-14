# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/snapshots.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Snapshots < Base
      # Get Snapshots
      #
      # Get a list of all own and imported Snapshots
      def get_custom_snapshots(company_id: nil, **_opts)
        request(
          method: :get,
          path: "/snapshots/",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact
        )
      end

      # Create Snapshot Share Link
      #
      # Create a share link for snapshot
      def create_snapshot_share_link(body:, company_id: nil, **_opts)
        request(
          method: :post,
          path: "/snapshots/share/link",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact,
          body: body
        )
      end

      # Get Snapshot Push between Dates
      #
      # Get list of sub-accounts snapshot pushed in time period
      def get_snapshot_push(snapshot_id:, company_id: nil, from: nil, to: nil, last_doc: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/snapshots/snapshot-status/#{snapshot_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id, "from" => from, "to" => to, "lastDoc" => last_doc, "limit" => limit }.compact
        )
      end

      # Get Last Snapshot Push
      #
      # Get Latest Snapshot Push Status for a location id
      def get_latest_snapshot_push(snapshot_id:, location_id:, company_id: nil, **_opts)
        request(
          method: :get,
          path: "/snapshots/snapshot-status/#{snapshot_id}/location/#{location_id}",
          security: ["Agency-Access"],
          params: { "companyId" => company_id }.compact
        )
      end
    end
  end
end
