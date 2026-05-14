# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Calendars < Base
      # Get Groups
      #
      # Get all calendar groups in a location.
      def get_groups(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/groups",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Calendar Group
      def create_calendar_group(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/groups",
          security: ["bearer"],
          body: body
        )
      end

      # Validate group slug
      #
      # Validate if group slug is available or not.
      def validate_groups_slug(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/groups/validate-slug",
          security: ["bearer"],
          body: body
        )
      end

      # Update Group
      #
      # Update Group by group ID
      def edit_group(group_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/groups/#{group_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Group
      def delete_group(group_id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/groups/#{group_id}",
          security: ["bearer"]
        )
      end

      # Disable Group
      def disable_group(group_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/groups/#{group_id}/status",
          security: ["bearer"],
          body: body
        )
      end

      # Create appointment
      def create_appointment(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/events/appointments",
          security: ["bearer"],
          body: body
        )
      end

      # Get Appointment
      #
      # Get appointment by ID
      def get_appointment(event_id:, **_opts)
        request(
          method: :get,
          path: "/calendars/events/appointments/#{event_id}",
          security: ["bearer"]
        )
      end

      # Update Appointment
      #
      # Update appointment
      def edit_appointment(event_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/events/appointments/#{event_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get Calendar Events
      def get_calendar_events(location_id: nil, user_id: nil, calendar_id: nil, group_id: nil, start_time: nil, end_time: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/events",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "calendarId" => calendar_id, "groupId" => group_id, "startTime" => start_time, "endTime" => end_time }.compact
        )
      end

      # Get Blocked Slots
      def get_blocked_slots(location_id: nil, user_id: nil, calendar_id: nil, group_id: nil, start_time: nil, end_time: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/blocked-slots",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "calendarId" => calendar_id, "groupId" => group_id, "startTime" => start_time, "endTime" => end_time }.compact
        )
      end

      # Create Block Slot
      #
      # Create block slot
      def create_block_slot(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/events/block-slots",
          security: ["bearer"],
          body: body
        )
      end

      # Update Block Slot
      #
      # Update block slot by ID
      def edit_block_slot(event_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/events/block-slots/#{event_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get Free Slots
      #
      # Get free slots for a calendar between a date range. Optionally a consumer can also request free slots in a particular timezone and also for a particular user.
      def get_slots(calendar_id:, start_date: nil, end_date: nil, timezone: nil, user_id: nil, user_ids: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/#{calendar_id}/free-slots",
          security: ["bearer"],
          params: { "startDate" => start_date, "endDate" => end_date, "timezone" => timezone, "userId" => user_id, "userIds" => user_ids }.compact
        )
      end

      # Get Calendar
      #
      # Get calendar by ID
      def get_calendar(calendar_id:, **_opts)
        request(
          method: :get,
          path: "/calendars/#{calendar_id}",
          security: ["bearer"]
        )
      end

      # Update Calendar
      #
      # Update calendar by ID.
      def update_calendar(calendar_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/#{calendar_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Calendar
      #
      # Delete calendar by ID
      def delete_calendar(calendar_id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/#{calendar_id}",
          security: ["bearer"]
        )
      end

      # Delete Event
      #
      # Delete event by ID
      def delete_event(event_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/calendars/events/#{event_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get Notes
      #
      # Get Appointment Notes
      def get_appointment_notes(appointment_id:, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/appointments/#{appointment_id}/notes",
          security: ["bearer"],
          params: { "limit" => limit, "offset" => offset }.compact
        )
      end

      # Create Note
      def create_appointment_note(appointment_id:, body:, **_opts)
        request(
          method: :post,
          path: "/calendars/appointments/#{appointment_id}/notes",
          security: ["bearer"],
          body: body
        )
      end

      # Update Note
      def update_appointment_note(appointment_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/appointments/#{appointment_id}/notes/#{note_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Note
      def delete_appointment_note(appointment_id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/appointments/#{appointment_id}/notes/#{note_id}",
          security: ["bearer"]
        )
      end

      # Get Calendar Resource
      #
      # Get calendar resource by ID
      def get_calendar_resource(resource_type:, id:, **_opts)
        request(
          method: :get,
          path: "/calendars/resources/#{resource_type}/#{id}",
          security: ["Location-Access"]
        )
      end

      # Update Calendar Resource
      #
      # Update calendar resource by ID
      def update_calendar_resource(resource_type:, id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/resources/#{resource_type}/#{id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete Calendar Resource
      #
      # Delete calendar resource by ID
      def delete_calendar_resource(resource_type:, id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/resources/#{resource_type}/#{id}",
          security: ["Location-Access"]
        )
      end

      # List Calendar Resources
      #
      # List calendar resources by resource type and location ID
      def fetch_calendar_resources(resource_type:, location_id: nil, limit: nil, skip: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/resources/#{resource_type}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "skip" => skip }.compact
        )
      end

      # Create Calendar Resource
      #
      # Create calendar resource by resource type
      def create_calendar_resource(resource_type:, body:, **_opts)
        request(
          method: :post,
          path: "/calendars/resources/#{resource_type}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Get notifications
      #
      # Get calendar notifications based on query
      def get_event_notification(calendar_id:, is_active: nil, deleted: nil, limit: nil, skip: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/#{calendar_id}/notifications",
          security: ["bearer"],
          params: { "isActive" => is_active, "deleted" => deleted, "limit" => limit, "skip" => skip }.compact
        )
      end

      # Create notification
      #
      # Create Calendar notifications, either one or multiple. All notification settings must be for single calendar only
      def create_event_notification(calendar_id:, body:, **_opts)
        request(
          method: :post,
          path: "/calendars/#{calendar_id}/notifications",
          security: ["bearer"],
          body: body
        )
      end

      # Get notification
      #
      # Find Event notification by notificationId
      def find_event_notification(calendar_id:, notification_id:, **_opts)
        request(
          method: :get,
          path: "/calendars/#{calendar_id}/notifications/#{notification_id}",
          security: ["bearer"]
        )
      end

      # Update notification
      #
      # Update Event notification by id
      def update_event_notification(calendar_id:, notification_id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/#{calendar_id}/notifications/#{notification_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Notification
      #
      # Delete notification
      def delete_event_notification(calendar_id:, notification_id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/#{calendar_id}/notifications/#{notification_id}",
          security: ["bearer"]
        )
      end

      # List user availability schedule
      #
      # Retrieve user availability schedules based on various filters including location, calendar, and user. Supports pagination.
      def get_all_schedules(location_id: nil, user_id: nil, calendar_id: nil, skip: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/schedules/search",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "calendarId" => calendar_id, "skip" => skip, "limit" => limit }.compact
        )
      end

      # Get user availability schedule
      #
      # Retrieve a specific schedule by its unique identifier. Returns detailed information including rules, timezone, and associated calendars/users.
      def get_schedule_by_id(id:, **_opts)
        request(
          method: :get,
          path: "/calendars/schedules/#{id}",
          security: ["bearer"]
        )
      end

      # Update user availability schedule
      #
      # Modify an existing schedule by updating its rules, timezone, and name All fields are optional - only provided fields will be updated.
      def update_schedule(id:, body:, **_opts)
        request(
          method: :put,
          path: "/calendars/schedules/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete user availability schedule
      #
      # Permanently remove a schedule and all its associated rules. This action cannot be undone.
      def delete_schedule(id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/schedules/#{id}",
          security: ["bearer"]
        )
      end

      # Create user availability schedule
      #
      # Create new schedule with specified rules, timezone, location, user and calendar associations.
      def create_schedule(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/schedules",
          security: ["bearer"],
          body: body
        )
      end

      # Apply user availability schedule to a calendar
      #
      # Associates a calendar with the given schedule by adding the calendarId to a schedule
      def add_calendar_to_schedule(id:, calendar_id:, **_opts)
        request(
          method: :put,
          path: "/calendars/schedules/#{id}/associations/#{calendar_id}",
          security: ["bearer"]
        )
      end

      # Remove user availability schedule from a calendar
      #
      # Removes the association between a team calendar and the given schedule by removing the calendarId from the schedule
      def remove_calendar_from_schedule(id:, calendar_id:, **_opts)
        request(
          method: :delete,
          path: "/calendars/schedules/#{id}/associations/#{calendar_id}",
          security: ["bearer"]
        )
      end

      # Get Calendars
      #
      # Get all calendars in a location.
      def get_calendars(location_id: nil, group_id: nil, show_drafted: nil, **_opts)
        request(
          method: :get,
          path: "/calendars/",
          security: ["bearer"],
          params: { "locationId" => location_id, "groupId" => group_id, "showDrafted" => show_drafted }.compact
        )
      end

      # Create Calendar
      #
      # Create calendar in a location.
      def create_calendar(body:, **_opts)
        request(
          method: :post,
          path: "/calendars/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
