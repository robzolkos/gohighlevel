# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/calendars.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Calendars
      CalendarCreateDTO = Data.define(:is_active, :notifications, :location_id, :group_id, :team_members, :event_type, :name, :description, :slug, :widget_slug, :calendar_type, :widget_type, :event_title, :event_color, :meeting_location, :location_configurations, :slot_duration, :slot_duration_unit, :slot_interval, :slot_interval_unit, :slot_buffer, :slot_buffer_unit, :pre_buffer, :pre_buffer_unit, :appoinment_per_slot, :appoinment_per_day, :allow_booking_after, :allow_booking_after_unit, :allow_booking_for, :allow_booking_for_unit, :open_hours, :enable_recurring, :recurring, :form_id, :sticky_contact, :is_live_payment_mode, :auto_confirm, :should_send_alert_emails_to_assigned_member, :alert_email, :google_invitation_emails, :allow_reschedule, :allow_cancellation, :should_assign_contact_to_team_member, :should_skip_assigning_contact_for_existing, :notes, :pixel_id, :form_submit_type, :form_submit_redirect_url, :form_submit_thanks_message, :availability_type, :availabilities, :guest_type, :consent_label, :calendar_cover_image, :look_busy_config)
    end
  end
end
