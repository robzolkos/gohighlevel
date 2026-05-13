# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Contacts < Base
      # Search Contacts
      #
      # Search contacts based on combinations of advanced filters. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-158396/6e629989abe7fad
      def search_contacts_advanced(body:, **_opts)
        request(
          method: :post,
          path: "/contacts/search",
          security: ["bearer"],
          body: body
        )
      end

      # Get Duplicate Contact
      #
      # Get Duplicate Contact.<br/><br/>If `Allow Duplicate Contact` is disabled under Settings, the global unique identifier will be used for searching the contact. If the setting is enabled, first priority for search is `email` and the second priority will be `phone`.
      def get_duplicate_contact(location_id: nil, number: nil, email: nil, **_opts)
        request(
          method: :get,
          path: "/contacts/search/duplicate",
          security: ["bearer"],
          params: { "locationId" => location_id, "number" => number, "email" => email }.compact
        )
      end

      # Get all Tasks
      def get_all_tasks(contact_id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}/tasks",
          security: ["bearer"]
        )
      end

      # Create Task
      def create_task(contact_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/tasks",
          security: ["bearer"],
          body: body
        )
      end

      # Get Task
      def get_task(contact_id:, task_id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}/tasks/#{task_id}",
          security: ["bearer"]
        )
      end

      # Update Task
      def update_task(contact_id:, task_id:, body:, **_opts)
        request(
          method: :put,
          path: "/contacts/#{contact_id}/tasks/#{task_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Task
      def delete_task(contact_id:, task_id:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/tasks/#{task_id}",
          security: ["bearer"]
        )
      end

      # Update Task Completed
      def update_task_completed(contact_id:, task_id:, body:, **_opts)
        request(
          method: :put,
          path: "/contacts/#{contact_id}/tasks/#{task_id}/completed",
          security: ["bearer"],
          body: body
        )
      end

      # Get Appointments for Contact
      def get_appointments_for_contact(contact_id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}/appointments",
          security: ["bearer"]
        )
      end

      # Add Tags
      def add_tags(contact_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/tags",
          security: ["bearer"],
          body: body
        )
      end

      # Remove Tags
      def remove_tags(contact_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/tags",
          security: ["bearer"],
          body: body
        )
      end

      # Get All Notes
      def get_all_notes(contact_id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}/notes",
          security: ["bearer"]
        )
      end

      # Create Note
      def create_note(contact_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/notes",
          security: ["bearer"],
          body: body
        )
      end

      # Get Note
      def get_note(contact_id:, id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}/notes/#{id}",
          security: ["bearer"]
        )
      end

      # Update Note
      def update_note(contact_id:, id:, body:, **_opts)
        request(
          method: :put,
          path: "/contacts/#{contact_id}/notes/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Note
      def delete_note(contact_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/notes/#{id}",
          security: ["bearer"]
        )
      end

      # Update Contacts Tags
      #
      # Allows you to update tags to multiple contacts at once, you can add or remove tags from the contacts
      def create_association(body:, **_opts)
        request(
          method: :post,
          path: "/contacts/bulk/tags/update/#{type}",
          security: [],
          body: body
        )
      end

      # Add/Remove Contacts From Business
      #
      # Add/Remove Contacts From Business . Passing a `null` businessId will remove the businessId from the contacts
      def add_remove_contact_from_business(body:, **_opts)
        request(
          method: :post,
          path: "/contacts/bulk/business",
          security: [],
          body: body
        )
      end

      # Get Contact
      def get_contact(contact_id:, **_opts)
        request(
          method: :get,
          path: "/contacts/#{contact_id}",
          security: ["bearer"]
        )
      end

      # Update Contact
      #
      # Please find the list of acceptable values for the `country` field  <a href="https://highlevel.stoplight.io/docs/integrations/ZG9jOjI4MzUzNDIy-country-list" target="_blank">here</a>
      def update_contact(contact_id:, body:, **_opts)
        request(
          method: :put,
          path: "/contacts/#{contact_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Contact
      def delete_contact(contact_id:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}",
          security: ["bearer"]
        )
      end

      # Upsert Contact
      #
      # Please find the list of acceptable values for the `country` field  <a href="https://highlevel.stoplight.io/docs/integrations/ZG9jOjI4MzUzNDIy-country-list" target="_blank">here</a><br/><br/>The Upsert API will adhere to the configuration defined under the “Allow Duplicate Contact” setting at the Location level. If the setting is configured to check both Email and Phone, the API will attempt to identify an existing contact based on the priority sequence specified in the setting, and will create or update the contact accordingly.<br/><br/>If two separate contacts already exist—one with the same email and another with the same phone—and an upsert request includes both the email and phone, the API will update the contact that matches the first field in the configured sequence, and ignore the second field to prevent duplication.
      def upsert_contact(body:, **_opts)
        request(
          method: :post,
          path: "/contacts/upsert",
          security: ["bearer"],
          body: body
        )
      end

      # Get Contacts By BusinessId
      def get_contacts_by_business_id(business_id:, limit: nil, location_id: nil, skip: nil, query: nil, **_opts)
        request(
          method: :get,
          path: "/contacts/business/#{business_id}",
          security: ["bearer"],
          params: { "limit" => limit, "locationId" => location_id, "skip" => skip, "query" => query }.compact
        )
      end

      # Add Followers
      def add_followers_contact(contact_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/followers",
          security: ["bearer"],
          body: body
        )
      end

      # Remove Followers
      def remove_followers_contact(contact_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/followers",
          security: ["bearer"],
          body: body
        )
      end

      # Add Contact to Campaign
      #
      # Add contact to Campaign
      def add_contact_to_campaign(contact_id:, campaign_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/campaigns/#{campaign_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Remove Contact From Campaign
      def remove_contact_from_campaign(contact_id:, campaign_id:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/campaigns/#{campaign_id}",
          security: ["bearer"]
        )
      end

      # Remove Contact From Every Campaign
      def remove_contact_from_every_campaign(contact_id:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/campaigns/removeAll",
          security: ["bearer"]
        )
      end

      # Add Contact to Workflow
      def add_contact_to_workflow(contact_id:, workflow_id:, body:, **_opts)
        request(
          method: :post,
          path: "/contacts/#{contact_id}/workflow/#{workflow_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Contact from Workflow
      def delete_contact_from_workflow(contact_id:, workflow_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/contacts/#{contact_id}/workflow/#{workflow_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get Contacts
      #
      # Get Contacts
      #
      #  **Note:** This API endpoint is deprecated. Please use the [Search Contacts](https://marketplace.gohighlevel.com/docs/ghl/contacts/search-contacts-advanced) endpoint instead.
      def get_contacts(location_id: nil, start_after_id: nil, start_after: nil, query: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/contacts/",
          security: ["bearer"],
          params: { "locationId" => location_id, "startAfterId" => start_after_id, "startAfter" => start_after, "query" => query, "limit" => limit }.compact
        )
      end

      # Create Contact
      #
      # Please find the list of acceptable values for the `country` field  <a href="https://highlevel.stoplight.io/docs/integrations/ZG9jOjI4MzUzNDIy-country-list" target="_blank">here</a>
      def create_contact(body:, **_opts)
        request(
          method: :post,
          path: "/contacts/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
