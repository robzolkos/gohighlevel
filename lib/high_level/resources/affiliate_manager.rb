# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/affiliate-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class AffiliateManager < Base
      # List Affiliates
      #
      # Retrieve the list of affiliates for a location.
      def list_affiliates(location_id:, query: nil, active: nil, campaign_id: nil, skip: nil, limit: nil, from_date: nil, to_date: nil, **_opts)
        request(
          method: :get,
          path: "/affiliate-manager/#{location_id}/affiliates",
          security: ["bearer"],
          params: { "query" => query, "active" => active, "campaignId" => campaign_id, "skip" => skip, "limit" => limit, "fromDate" => from_date, "toDate" => to_date }.compact
        )
      end

      # Get Affiliate
      #
      # Retrieve a single affiliate by id for a location.
      def get_affiliate(location_id:, affiliate_id:, **_opts)
        request(
          method: :get,
          path: "/affiliate-manager/#{location_id}/affiliates/#{affiliate_id}",
          security: ["bearer"]
        )
      end

      # List Payouts
      #
      # Retrieve the list of payouts for a location.
      def list_payouts(location_id:, status: nil, query: nil, affiliate_id: nil, campaign_id: nil, skip: nil, limit: nil, start: nil, end_: nil, **_opts)
        request(
          method: :get,
          path: "/affiliate-manager/#{location_id}/payouts",
          security: ["bearer"],
          params: { "status" => status, "query" => query, "affiliateId" => affiliate_id, "campaignId" => campaign_id, "skip" => skip, "limit" => limit, "start" => start, "end" => end_ }.compact
        )
      end

      # List Commissions
      #
      # Retrieve the list of commissions for a location.
      def list_commissions(location_id:, campaign_id: nil, affiliate_id: nil, status: nil, query: nil, skip: nil, limit: nil, from_date: nil, to_date: nil, **_opts)
        request(
          method: :get,
          path: "/affiliate-manager/#{location_id}/commissions",
          security: ["bearer"],
          params: { "campaignId" => campaign_id, "affiliateId" => affiliate_id, "status" => status, "query" => query, "skip" => skip, "limit" => limit, "fromDate" => from_date, "toDate" => to_date }.compact
        )
      end
    end
  end
end
