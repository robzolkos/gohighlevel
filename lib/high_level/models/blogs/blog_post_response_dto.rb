# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/blogs.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Blogs
      BlogPostResponseDTO = Data.define(:categories, :tags, :archived, :id, :title, :description, :image_url, :status, :image_alt_text, :url_slug, :canonical_link, :author, :published_at, :updated_at)
    end
  end
end
