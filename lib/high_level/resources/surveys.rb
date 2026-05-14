# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/surveys.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Surveys < Base
      # Get Surveys Submissions
      def get_surveys_submissions(location_id: nil, page: nil, limit: nil, survey_id: nil, q: nil, start_at: nil, end_at: nil, **_opts)
        request(
          method: :get,
          path: "/surveys/submissions",
          security: ["bearer"],
          params: { "locationId" => location_id, "page" => page, "limit" => limit, "surveyId" => survey_id, "q" => q, "startAt" => start_at, "endAt" => end_at }.compact
        )
      end

      # Get Surveys
      def get_surveys(location_id: nil, skip: nil, limit: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/surveys/",
          security: ["bearer"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit, "type" => type }.compact
        )
      end
    end
  end
end
