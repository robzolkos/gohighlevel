# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/blogs.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Blogs < Base
      # Check url slug
      #
      # The "Check url slug" API allows check the blog slug validation which is needed before publishing any blog post. Please use blogs/check-slug.readonly. you can find the POST ID from the post edit url.
      def check_url_slug_exists(url_slug: nil, location_id: nil, post_id: nil, **_opts)
        request(
          method: :get,
          path: "/blogs/posts/url-slug-exists",
          security: ["Location-Access"],
          params: { "urlSlug" => url_slug, "locationId" => location_id, "postId" => post_id }.compact
        )
      end

      # Update Blog Post
      #
      # The "Update Blog Post" API allows you update blog post for any given blog site. Please use blogs/post-update.write
      def update_blog_post(body:, **_opts)
        request(
          method: :put,
          path: "/blogs/posts/#{post_id}",
          security: ["Location-Access"],
          body: body
        )
      end

      # Create Blog Post
      #
      # The "Create Blog Post" API allows you create blog post for any given blog site. Please use blogs/post.write
      def create_blog_post(body:, **_opts)
        request(
          method: :post,
          path: "/blogs/posts",
          security: ["Location-Access"],
          body: body
        )
      end

      # Get all authors
      #
      # The "Get all authors" Api return the blog authors for a given location ID. Please use "blogs/author.readonly"
      def get_all_blog_authors_by_location(location_id: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/blogs/authors",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Get all categories
      #
      # The "Get all categories" Api return the blog categoies for a given location ID. Please use "blogs/category.readonly"
      def get_all_categories_by_location(location_id: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/blogs/categories",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Get Blog posts by Blog ID
      #
      # The "Get Blog posts by Blog ID" API allows you get blog posts for any given blog site using blog ID.Please use blogs/posts.readonly
      def get_blog_post(location_id: nil, blog_id: nil, limit: nil, offset: nil, search_term: nil, status: nil, **_opts)
        request(
          method: :get,
          path: "/blogs/posts/all",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "blogId" => blog_id, "limit" => limit, "offset" => offset, "searchTerm" => search_term, "status" => status }.compact
        )
      end

      # Get Blogs by Location ID
      #
      # The "Get Blogs by Location ID" API allows you get blogs using Location ID.Please use blogs/list.readonly
      def get_blogs(location_id: nil, skip: nil, limit: nil, search_term: nil, **_opts)
        request(
          method: :get,
          path: "/blogs/site/all",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit, "searchTerm" => search_term }.compact
        )
      end
    end
  end
end
