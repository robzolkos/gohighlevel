# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/contacts.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Contacts
      GetNoteSchema = Data.define(:id, :body, :user_id, :date_added, :contact_id, :title, :color, :pinned)
    end
  end
end
