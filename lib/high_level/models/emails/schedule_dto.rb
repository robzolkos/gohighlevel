# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/emails.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Emails
      ScheduleDto = Data.define(:name, :repeat_after, :id, :parent_id, :child_count, :campaign_type, :bulk_action_version, :id, :status, :send_days, :deleted, :migrated, :archived, :has_tracking, :is_plain_text, :has_utm_tracking, :enable_resend_to_unopened, :location_id, :template_id, :template_type, :created_at, :updated_at, :v, :document_id, :download_url, :template_data_download_url, :child)
    end
  end
end
