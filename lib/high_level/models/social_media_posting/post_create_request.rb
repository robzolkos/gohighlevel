# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/social-media-posting.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Models
    module SocialMediaPosting
      PostCreateRequest = Data.define(:account_ids, :summary, :media, :status, :schedule_date, :created_by, :follow_up_comment, :og_tags_details, :type, :post_approval_details, :schedule_time_updated, :tags, :category_id, :tiktok_post_details, :gmb_post_details, :user_id)
    end
  end
end
