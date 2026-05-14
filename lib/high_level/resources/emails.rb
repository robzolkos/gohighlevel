# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/emails.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Emails < Base
      # Get Campaigns
      def fetch_campaigns(location_id: nil, limit: nil, offset: nil, status: nil, email_status: nil, name: nil, parent_id: nil, limited_fields: nil, archived: nil, campaigns_only: nil, show_stats: nil, **_opts)
        request(
          method: :get,
          path: "/emails/schedule",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset, "status" => status, "emailStatus" => email_status, "name" => name, "parentId" => parent_id, "limitedFields" => limited_fields, "archived" => archived, "campaignsOnly" => campaigns_only, "showStats" => show_stats }.compact
        )
      end

      # Fetch email templates
      #
      # Fetch email templates by location id
      def fetch_template(location_id: nil, limit: nil, offset: nil, search: nil, sort_by_date: nil, archived: nil, builder_version: nil, name: nil, parent_id: nil, origin_id: nil, templates_only: nil, **_opts)
        request(
          method: :get,
          path: "/emails/builder",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset, "search" => search, "sortByDate" => sort_by_date, "archived" => archived, "builderVersion" => builder_version, "name" => name, "parentId" => parent_id, "originId" => origin_id, "templatesOnly" => templates_only }.compact
        )
      end

      # Create a new template
      def create_template(body:, **_opts)
        request(
          method: :post,
          path: "/emails/builder",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete a template
      def delete_template(location_id:, template_id:, **_opts)
        request(
          method: :delete,
          path: "/emails/builder/#{location_id}/#{template_id}",
          security: ["Location-Access"]
        )
      end

      # Update a template
      def update_template(body:, **_opts)
        request(
          method: :post,
          path: "/emails/builder/data",
          security: ["Location-Access"],
          body: body
        )
      end
    end
  end
end
