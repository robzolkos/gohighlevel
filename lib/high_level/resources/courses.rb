# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/courses.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Courses < Base
      # Import Courses
      #
      # Import Courses through public channels
      def import_courses(body:, **_opts)
        request(
          method: :post,
          path: "/courses/courses-exporter/public/import",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
