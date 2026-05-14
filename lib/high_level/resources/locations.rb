# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/locations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Locations < Base
      # Search
      #
      # Search Sub-Account (Formerly Location)
      def search_locations(company_id: nil, skip: nil, limit: nil, order: nil, email: nil, **_opts)
        request(
          method: :get,
          path: "/locations/search",
          security: %w[Agency-Access Location-Access],
          params: { "companyId" => company_id, "skip" => skip, "limit" => limit, "order" => order, "email" => email }.compact
        )
      end

      # Get Sub-Account (Formerly Location)
      #
      # Get details of a Sub-Account (Formerly Location) by passing the sub-account id
      def get_location(location_id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}",
          security: %w[Location-Access Agency-Access]
        )
      end

      # Put Sub-Account (Formerly Location)
      #
      # Update a Sub-Account (Formerly Location) based on the data provided
      def put_location(location_id:, body:, **_opts)
        request(
          method: :put,
          path: "/locations/#{location_id}",
          security: ["Agency-Access"],
          body: body
        )
      end

      # Delete Sub-Account (Formerly Location)
      #
      # Delete a Sub-Account (Formerly Location) from the Agency
      def delete_location(location_id:, delete_twilio_account: nil, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}",
          security: ["Agency-Access"],
          params: { "deleteTwilioAccount" => delete_twilio_account }.compact
        )
      end

      # Get Tags
      #
      # Get Sub-Account (Formerly Location) Tags
      def get_location_tags(location_id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/tags",
          security: ["bearer"]
        )
      end

      # Create Tag
      #
      # Create tag
      def create_tag(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/tags",
          security: ["bearer"],
          body: body
        )
      end

      # Get tag by id
      def get_tag_by_id(location_id:, tag_id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/tags/#{tag_id}",
          security: ["bearer"]
        )
      end

      # Update tag
      def update_tag(location_id:, tag_id:, body:, **_opts)
        request(
          method: :put,
          path: "/locations/#{location_id}/tags/#{tag_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete tag
      def delete_tag(location_id:, tag_id:, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}/tags/#{tag_id}",
          security: ["bearer"]
        )
      end

      # Task Search Filter
      #
      # Task Search
      def task_search(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/tasks/search",
          security: ["bearer"],
          body: body
        )
      end

      # Get Recurring Task By Id
      def get_recurring_task_by_id(id:, location_id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/recurring-tasks/#{id}",
          security: ["bearer"]
        )
      end

      # Update Recurring Task
      def update_recurring_task(id:, location_id:, body:, **_opts)
        request(
          method: :put,
          path: "/locations/#{location_id}/recurring-tasks/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Recurring Task
      def delete_recurring_task(id:, location_id:, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}/recurring-tasks/#{id}",
          security: ["bearer"]
        )
      end

      # Create Recurring Task
      def create_recurring_task(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/recurring-tasks",
          security: ["bearer"],
          body: body
        )
      end

      # Get Custom Fields
      def get_custom_fields(location_id:, model: nil, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/customFields",
          security: ["bearer"],
          params: { "model" => model }.compact
        )
      end

      # Create Custom Field
      def create_custom_field(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/customFields",
          security: ["bearer"],
          body: body
        )
      end

      # Get Custom Field
      def get_custom_field(location_id:, id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/customFields/#{id}",
          security: ["bearer"]
        )
      end

      # Update Custom Field
      def update_custom_field(location_id:, id:, body:, **_opts)
        request(
          method: :put,
          path: "/locations/#{location_id}/customFields/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Custom Field
      def delete_custom_field(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}/customFields/#{id}",
          security: ["bearer"]
        )
      end

      # Uploads File to customFields
      def upload_file_custom_fields(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/customFields/upload",
          security: ["bearer"],
          body: body
        )
      end

      # Get Custom Values
      def get_custom_values(location_id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/customValues",
          security: ["bearer"]
        )
      end

      # Create Custom Value
      def create_custom_value(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/locations/#{location_id}/customValues",
          security: ["bearer"],
          body: body
        )
      end

      # Get Custom Value
      def get_custom_value(location_id:, id:, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/customValues/#{id}",
          security: ["bearer"]
        )
      end

      # Update Custom Value
      def update_custom_value(location_id:, id:, body:, **_opts)
        request(
          method: :put,
          path: "/locations/#{location_id}/customValues/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Custom Value
      def delete_custom_value(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}/customValues/#{id}",
          security: ["bearer"]
        )
      end

      # Fetch Timezones
      #
      # Fetch the available timezones
      def get_timezones(**_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/timezones",
          security: %w[bearer Location-Access]
        )
      end

      # GET all or email/sms templates
      def get_all_or_email_sms_templates(location_id:, deleted: nil, skip: nil, limit: nil, type: nil, origin_id: nil, **_opts)
        request(
          method: :get,
          path: "/locations/#{location_id}/templates",
          security: ["bearer"],
          params: { "deleted" => deleted, "skip" => skip, "limit" => limit, "type" => type, "originId" => origin_id }.compact
        )
      end

      # DELETE an email/sms template
      def delete_an_email_sms_template(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/locations/#{location_id}/templates/#{id}",
          security: ["bearer"]
        )
      end

      # Create Sub-Account (Formerly Location)
      #
      # <div>
      #                   <p>Create a new Sub-Account (Formerly Location) based on the data provided</p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                           This feature is only available on Agency Pro ($497) plan.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      #
      def create_location(body:, **_opts)
        request(
          method: :post,
          path: "/locations/",
          security: ["Agency-Access"],
          body: body
        )
      end
    end
  end
end
