# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/funnels.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Funnels
      RedirectResponseDTO = Data.define(:id, :location_id, :domain, :path, :path_lowercase, :type, :target, :action)
    end
  end
end
