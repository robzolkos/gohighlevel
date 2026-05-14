# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/emails.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Emails
      SaveBuilderDataDto = Data.define(:location_id, :template_id, :updated_by, :dnd, :html, :editor_type, :preview_text, :is_plain_text)
    end
  end
end
