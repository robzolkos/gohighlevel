# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/forms.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Forms < Base
      # Get Forms Submissions
      def get_forms_submissions(location_id: nil, page: nil, limit: nil, form_id: nil, q: nil, start_at: nil, end_at: nil, **_opts)
        request(
          method: :get,
          path: "/forms/submissions",
          security: ["bearer"],
          params: { "locationId" => location_id, "page" => page, "limit" => limit, "formId" => form_id, "q" => q, "startAt" => start_at, "endAt" => end_at }.compact
        )
      end

      # Upload files to custom fields
      #
      # Post the necessary fields for the API to upload files. The files need to be a buffer with the key "< custom_field_id >_< file_id >". <br /> Here custom field id is the ID of your custom field and file id is a randomly generated id (or uuid) <br /> There is support for multiple file uploads as well. Have multiple fields in the format mentioned.<br />File size is limited to 50 MB.<br /><br /> The allowed file types are: <br/> <ul><li>PDF</li><li>DOCX</li><li>DOC</li><li>JPG</li><li>JPEG</li><li>PNG</li><li>GIF</li><li>CSV</li><li>XLSX</li><li>XLS</li><li>MP4</li><li>MPEG</li><li>ZIP</li><li>RAR</li><li>TXT</li><li>SVG</li></ul> <br /><br /> The API will return the updated contact object.
      def upload_to_custom_fields(body:, contact_id: nil, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/forms/upload-custom-files",
          security: %w[bearer Location-Access],
          params: { "contactId" => contact_id, "locationId" => location_id }.compact,
          body: body
        )
      end

      # Get Forms
      def get_forms(location_id: nil, skip: nil, limit: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/forms/",
          security: ["bearer"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit, "type" => type }.compact
        )
      end
    end
  end
end
