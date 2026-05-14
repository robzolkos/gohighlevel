# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/blogs.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module Blogs
      CreateBlogPostParams = Data.define(:title, :location_id, :blog_id, :image_url, :description, :raw_html, :status, :image_alt_text, :categories, :tags, :author, :url_slug, :canonical_link, :published_at)
    end
  end
end
