# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/social-media-posting.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class SocialMediaPosting < Base
      # Starts OAuth For Google Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to Google login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "google"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch Google account details using below API -
      #   API: '/social-media-posting/oauth/google/accounts/:accountId'
      #
      #   Method: GET
      def start_google_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/google/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get google business locations
      def get_google_locations(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/google/locations/#{account_id}",
          security: ["bearer"]
        )
      end

      # Set google business locations
      def set_google_locations(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/google/locations/#{account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get posts
      #
      # Get Posts
      def get_posts(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/posts/list",
          security: ["bearer"],
          body: body
        )
      end

      # Create post
      #
      # Create posts for all supported platforms. It is possible to create customized posts per channel by using the same platform account IDs in a request and hitting the create post API multiple times with different summaries and account IDs per platform.
      #
      # The content and media limitations, as well as platform rate limiters corresponding to the respective platforms, are provided in the following reference link:
      #
      #   Link: [Platform Limitations](https://help.leadconnectorhq.com/support/solutions/articles/48001240003-social-planner-image-video-content-and-api-limitations "Social Planner Help")
      def create_post(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/posts",
          security: ["bearer"],
          body: body
        )
      end

      # Get post
      def get_post(location_id:, id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/posts/#{id}",
          security: ["bearer"]
        )
      end

      # Edit post
      #
      # Create posts for all supported platforms. It is possible to create customized posts per channel by using the same platform account IDs in a request and hitting the create post API multiple times with different summaries and account IDs per platform.
      #
      # The content and media limitations, as well as platform rate limiters corresponding to the respective platforms, are provided in the following reference link:
      #
      #   Link: [Platform Limitations](https://help.leadconnectorhq.com/support/solutions/articles/48001240003-social-planner-image-video-content-and-api-limitations "Social Planner Help")
      def edit_post(location_id:, id:, body:, **_opts)
        request(
          method: :put,
          path: "/social-media-posting/#{location_id}/posts/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Post
      def delete_post(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/social-media-posting/#{location_id}/posts/#{id}",
          security: ["bearer"]
        )
      end

      # Bulk Delete Social Planner Posts
      #
      # Deletes multiple posts based on the provided list of post IDs.
      #                   This operation is useful for clearing up large numbers of posts efficiently.
      #
      # Note:
      #
      # 1.The maximum number of posts that can be deleted in a single request is '50'.
      #
      # 2.However, It will only get deleted in Highlevel database but still
      #                    it is recommended to be cautious of this operation.
      def bulk_delete_social_planner_posts(body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/posts/bulk-delete",
          security: [],
          body: body
        )
      end

      # Get Accounts
      #
      # Get list of accounts and groups
      def get_account(location_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/accounts",
          security: ["bearer"]
        )
      end

      # Delete Account
      #
      # Delete account and account from group
      def delete_account(location_id:, id:, company_id: nil, user_id: nil, **_opts)
        request(
          method: :delete,
          path: "/social-media-posting/#{location_id}/accounts/#{id}",
          security: ["bearer"],
          params: { "companyId" => company_id, "userId" => user_id }.compact
        )
      end

      # Starts OAuth For Facebook Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to Facebook login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "facebook"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch Facebook account details using below API -
      #   API: '/social-media-posting/oauth/facebook/accounts/:accountId'
      #
      #   Method: GET
      def start_facebook_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/facebook/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get facebook pages
      def get_facebook_page_group(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/facebook/accounts/#{account_id}",
          security: ["bearer"]
        )
      end

      # Attach facebook pages
      def attach_facebook_page_group(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/facebook/accounts/#{account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Starts OAuth For Instagram Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to Instagram login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "instagram"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch Instagram account details using below API -
      #   API: '/social-media-posting/oauth/instagram/accounts/:accountId'
      #
      #   Method: GET
      def start_instagram_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/instagram/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get Instagram Professional Accounts
      def get_instagram_page_group(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/instagram/accounts/#{account_id}",
          security: ["bearer"]
        )
      end

      # Attach Instagram Professional Accounts
      def attach_instagram_page_group(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/instagram/accounts/#{account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Starts OAuth For LinkedIn Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to LinkedIn login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "linkedin"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch LinkedIn account details using below API -
      #   API: '/social-media-posting/oauth/linkedin/accounts/:accountId'
      #
      #   Method: GET
      def start_linkedin_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/linkedin/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get Linkedin pages and profile
      def get_linkedin_page_profile(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/linkedin/accounts/#{account_id}",
          security: ["bearer"]
        )
      end

      # Attach linkedin pages and profile
      def attach_linkedin_page_profile(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/linkedin/accounts/#{account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Starts OAuth For Twitter Account
      #
      # <div><div>
      #   <span style= "display: inline-block;
      #     width: 25px; height: 25px;
      #     background-color: red;
      #     color: black;
      #     font-weight: bold;
      #     font-size: 24px;
      #     text-align: center;
      #     line-height: 20px;
      #     border: 2px solid black;
      #     border-radius: 20%;
      #     margin-right: 10px;">
      #     !
      #   </span>
      #   <span><strong>As of December 4, 2024, X (formerly Twitter) is no longer supported. We apologise for any inconvenience.</strong></span>
      # </div></div>
      def start_twitter_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/twitter/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get Twitter profile
      #
      # <div><div>
      #   <span style= "display: inline-block;
      #     width: 25px; height: 25px;
      #     background-color: red;
      #     color: black;
      #     font-weight: bold;
      #     font-size: 24px;
      #     text-align: center;
      #     line-height: 20px;
      #     border: 2px solid black;
      #     border-radius: 20%;
      #     margin-right: 10px;">
      #     !
      #   </span>
      #   <span><strong>As of December 4, 2024, X (formerly Twitter) is no longer supported. We apologise for any inconvenience.</strong></span>
      # </div></div>
      def get_twitter_profile(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/twitter/accounts/#{account_id}",
          security: []
        )
      end

      # Attach Twitter profile
      #
      # <div><div>
      #   <span style= "display: inline-block;
      #     width: 25px; height: 25px;
      #     background-color: red;
      #     color: black;
      #     font-weight: bold;
      #     font-size: 24px;
      #     text-align: center;
      #     line-height: 20px;
      #     border: 2px solid black;
      #     border-radius: 20%;
      #     margin-right: 10px;">
      #     !
      #   </span>
      #   <span><strong>As of December 4, 2024, X (formerly Twitter) is no longer supported. We apologise for any inconvenience.</strong></span>
      # </div></div>
      def attach_twitter_profile(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/twitter/accounts/#{account_id}",
          security: [],
          body: body
        )
      end

      # Get Upload Status
      def get_upload_status(location_id:, skip: nil, limit: nil, include_users: nil, user_id: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/csv",
          security: ["bearer"],
          params: { "skip" => skip, "limit" => limit, "includeUsers" => include_users, "userId" => user_id }.compact
        )
      end

      # Upload CSV
      def upload_csv(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/csv",
          security: ["bearer"],
          body: body
        )
      end

      # Set Accounts
      def set_accounts(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/set-accounts",
          security: ["bearer"],
          body: body
        )
      end

      # Get CSV Post
      def get_csv_post(location_id:, id:, skip: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/csv/#{id}",
          security: ["bearer"],
          params: { "skip" => skip, "limit" => limit }.compact
        )
      end

      # Start CSV Finalize
      def start_csv_finalize(location_id:, id:, body:, **_opts)
        request(
          method: :patch,
          path: "/social-media-posting/#{location_id}/csv/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete CSV
      def delete_csv(location_id:, id:, **_opts)
        request(
          method: :delete,
          path: "/social-media-posting/#{location_id}/csv/#{id}",
          security: ["bearer"]
        )
      end

      # Delete CSV Post
      def delete_csv_post(location_id:, post_id:, csv_id:, **_opts)
        request(
          method: :delete,
          path: "/social-media-posting/#{location_id}/csv/#{csv_id}/post/#{post_id}",
          security: ["bearer"]
        )
      end

      # Starts OAuth For Tiktok Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to Tiktok login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "tiktok"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch Tiktok account details using below API -
      #   API: '/social-media-posting/oauth/tiktok/accounts/:accountId'
      #
      #   Method: GET
      def start_tiktok_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/tiktok/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get Tiktok profile
      def get_tiktok_profile(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/tiktok/accounts/#{account_id}",
          security: ["bearer"]
        )
      end

      # Attach Tiktok profile
      def attach_tiktok_profile(location_id:, account_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/oauth/#{location_id}/tiktok/accounts/#{account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Starts OAuth For Tiktok Business Account
      #
      # Open the API in a window with appropriate params and headers instead of using the Curl. User is navigated to Tiktok-Business login OAuth screen. On successful login, listen on window object for message where event listener returns data in its callback function.
      #   ### Sample code to listen to event data:
      #     window.addEventListener('message',
      #       function(e) {
      #         if (e.data && e.data.page === 'social_media_posting') {
      #         const { actionType, page, platform, placement, accountId, reconnectAccounts } = e.data
      #         }
      #       },
      #     false)
      #   ### Event Data Response:
      #     {
      #       actionType: string,            Ex: "close"
      #       page: string,                  Ex: "social-media-posting"
      #       platform: string,              Ex: "tiktok-business"
      #       placement: string,             Ex: "placement"
      #       accountId: string,             Ex: "658a9b6833b91e0ecb8f3958"
      #       reconnectAccounts: string[]]   Ex: ["658a9b6833b91e0ecb834acd", "efd2daa9b6833b91e0ecb8f3511"]
      #     }
      #   ### The accountId retrieved from above data can be used to fetch Tiktok-Business account details using below API -
      #   API: '/social-media-posting/oauth/tiktok-business/accounts/:accountId'
      #
      #   Method: GET
      def start_tiktok_business_oauth(location_id: nil, user_id: nil, page: nil, reconnect: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/tiktok-business/start",
          security: ["bearer"],
          params: { "locationId" => location_id, "userId" => user_id, "page" => page, "reconnect" => reconnect }.compact
        )
      end

      # Get Tiktok Business profile
      def get_tiktok_business_profile(location_id:, account_id:, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/oauth/#{location_id}/tiktok-business/accounts/#{account_id}",
          security: ["bearer"]
        )
      end

      # Get categories by location id
      def get_categories_location_id(location_id:, search_text: nil, limit: nil, skip: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/categories",
          security: ["bearer"],
          params: { "searchText" => search_text, "limit" => limit, "skip" => skip }.compact
        )
      end

      # Get categories by id
      def get_categories_id(id:, location_id:, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/categories/#{id}",
          security: ["bearer"],
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Get tags by location id
      def get_tags_location_id(location_id:, search_text: nil, limit: nil, skip: nil, **_opts)
        request(
          method: :get,
          path: "/social-media-posting/#{location_id}/tags",
          security: ["bearer"],
          params: { "searchText" => search_text, "limit" => limit, "skip" => skip }.compact
        )
      end

      # Get tags by ids
      def get_tags_by_ids(location_id:, body:, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/#{location_id}/tags/details",
          security: ["bearer"],
          body: body
        )
      end

      # Get Social Media Statistics
      #
      # Retrieve analytics data for multiple social media accounts. Provides metrics for the last 7 days with comparison to the previous 7 days. Supports filtering by platforms and specific connected accounts.
      def get_social_media_statistics(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/social-media-posting/statistics",
          security: [],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end
    end
  end
end
