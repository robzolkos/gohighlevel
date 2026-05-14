# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/proposals.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Proposals
      DocumentDto = Data.define(:location_id, :document_id, :id, :name, :type, :deleted, :is_expired, :document_revision, :fillable_fields, :grand_total, :locale, :status, :payment_status, :recipients, :links, :updated_at, :created_at)
    end
  end
end
