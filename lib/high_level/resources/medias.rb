# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/medias.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Medias < Base
      # Get List of Files/ Folders
      #
      # Fetches list of files and folders from the media storage
      def fetch_media_content(offset: nil, limit: nil, sort_by: nil, sort_order: nil, type: nil, query: nil, alt_type: nil, alt_id: nil, parent_id: nil, fetch_all: nil, **_opts)
        request(
          method: :get,
          path: "/medias/files",
          security: ["Location-Access"],
          params: { "offset" => offset, "limit" => limit, "sortBy" => sort_by, "sortOrder" => sort_order, "type" => type, "query" => query, "altType" => alt_type, "altId" => alt_id, "parentId" => parent_id, "fetchAll" => fetch_all }.compact
        )
      end

      # Upload File into Media Storage
      #
      # If hosted is set to true then fileUrl is required. Else file is required. If adding a file, maximum allowed is 25 MB
      def upload_media_content(body:, **_opts)
        request(
          method: :post,
          path: "/medias/upload-file",
          security: ["Location-Access"],
          body: body
        )
      end

      # Update File/ Folder
      #
      # Updates a single file or folder by ID
      def update_media_object(id:, body:, **_opts)
        request(
          method: :post,
          path: "/medias/#{id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Delete File or Folder
      #
      # Deletes specific file or folder from the media storage
      def delete_media_content(id:, alt_type: nil, alt_id: nil, **_opts)
        request(
          method: :delete,
          path: "/medias/#{id}",
          security: ["Location-Access"],
          params: { "altType" => alt_type, "altId" => alt_id }.compact
        )
      end

      # Create Folder
      #
      # Creates a new folder in the media storage
      def create_media_folder(body:, **_opts)
        request(
          method: :post,
          path: "/medias/folder",
          security: ["Location-Access"],
          body: body
        )
      end

      # Bulk Update Files/ Folders
      #
      # Updates metadata or status of multiple files and folders
      def bulk_update_media_objects(body:, **_opts)
        request(
          method: :put,
          path: "/medias/update-files",
          security: ["Location-Access"],
          body: body
        )
      end

      # Bulk Delete / Trash Files or Folders
      #
      # Soft-deletes or trashes multiple files and folders in a single request
      def bulk_delete_media_objects(body:, **_opts)
        request(
          method: :put,
          path: "/medias/delete-files",
          security: ["Location-Access"],
          body: body
        )
      end
    end
  end
end
