# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/opportunities.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Opportunities < Base
      # Get lost reason
      def get_lost_reason(location_id: nil, name: nil, deleted: nil, query: nil, skip: nil, limit: nil, get_count: nil, **_opts)
        request(
          method: :get,
          path: "/opportunities/lost-reason",
          security: ["bearer"],
          params: { "locationId" => location_id, "name" => name, "deleted" => deleted, "query" => query, "skip" => skip, "limit" => limit, "getCount" => get_count }.compact
        )
      end

      # Search Opportunity
      def search_opportunity(q: nil, location_id: nil, pipeline_id: nil, pipeline_stage_id: nil, contact_id: nil, status: nil, assigned_to: nil, campaign_id: nil, id: nil, order: nil, end_date: nil, start_after: nil, start_after_id: nil, date: nil, country: nil, page: nil, limit: nil, get_tasks: nil, get_notes: nil, get_calendar_events: nil, **_opts)
        request(
          method: :get,
          path: "/opportunities/search",
          security: ["bearer"],
          params: { "q" => q, "location_id" => location_id, "pipeline_id" => pipeline_id, "pipeline_stage_id" => pipeline_stage_id, "contact_id" => contact_id, "status" => status, "assigned_to" => assigned_to, "campaignId" => campaign_id, "id" => id, "order" => order, "endDate" => end_date, "startAfter" => start_after, "startAfterId" => start_after_id, "date" => date, "country" => country, "page" => page, "limit" => limit, "getTasks" => get_tasks, "getNotes" => get_notes, "getCalendarEvents" => get_calendar_events }.compact
        )
      end

      # Search Opportunities
      #
      # Search Opportunities based on combinations of advanced filters. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-424216/7bf11bc9b94f80f
      def search_opportunities_advanced(body:, **_opts)
        request(
          method: :post,
          path: "/opportunities/search",
          security: ["bearer"],
          body: body
        )
      end

      # Get Pipelines
      def get_pipelines(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/opportunities/pipelines",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get Opportunity
      def get_opportunity(id:, **_opts)
        request(
          method: :get,
          path: "/opportunities/#{id}",
          security: ["bearer"]
        )
      end

      # Update Opportunity
      def update_opportunity(id:, body:, **_opts)
        request(
          method: :put,
          path: "/opportunities/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Opportunity
      def delete_opportunity(id:, **_opts)
        request(
          method: :delete,
          path: "/opportunities/#{id}",
          security: ["bearer"]
        )
      end

      # Update Opportunity Status
      def update_opportunity_status(id:, body:, **_opts)
        request(
          method: :put,
          path: "/opportunities/#{id}/status",
          security: ["bearer"],
          body: body
        )
      end

      # Upsert Opportunity
      def upsert_opportunity(body:, **_opts)
        request(
          method: :post,
          path: "/opportunities/upsert",
          security: ["bearer"],
          body: body
        )
      end

      # Add Followers
      def add_followers_opportunity(id:, body:, **_opts)
        request(
          method: :post,
          path: "/opportunities/#{id}/followers",
          security: ["bearer"],
          body: body
        )
      end

      # Remove Followers
      #
      # Allows removal of one or all followers from an opportunity.
      def remove_followers_opportunity(id:, body:, is_remove_all_followers: nil, **_opts)
        request(
          method: :delete,
          path: "/opportunities/#{id}/followers",
          security: ["bearer"],
          params: { "isRemoveAllFollowers" => is_remove_all_followers }.compact,
          body: body
        )
      end

      # Create Opportunity
      def create_opportunity(body:, **_opts)
        request(
          method: :post,
          path: "/opportunities/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
