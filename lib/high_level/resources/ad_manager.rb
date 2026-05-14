# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/ad-manager.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class AdManager < Base
      # Get reporting data
      #
      # Retrieve aggregated Facebook ad reporting metrics for a location
      def fb_get_reporting(location_id: nil, group_by: nil, start_date: nil, end_date: nil, type: nil, fields: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/reporting",
          security: ["bearer"],
          params: { "locationId" => location_id, "groupBy" => group_by, "startDate" => start_date, "endDate" => end_date, "type" => type, "fields" => fields }.compact
        )
      end

      # Get campaign reporting
      #
      # Retrieve reporting metrics for a specific Facebook campaign
      def fb_get_campaign_reporting(campaign_id:, location_id: nil, start_date: nil, end_date: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/reporting/campaign/#{campaign_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "startDate" => start_date, "endDate" => end_date }.compact
        )
      end

      # Get reporting list
      #
      # Retrieve a list of Facebook campaigns, adsets, or ads with reporting data
      def fb_get_reporting_list(location_id: nil, list_type: nil, start_date: nil, end_date: nil, campaign_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/reporting/list",
          security: ["bearer"],
          params: { "locationId" => location_id, "listType" => list_type, "startDate" => start_date, "endDate" => end_date, "campaignId" => campaign_id, "type" => type }.compact
        )
      end

      # Get current Facebook user
      #
      # Retrieve the authenticated Facebook user profile for a location
      def fb_get_current_user(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/me",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get Facebook pages
      #
      # Retrieve Facebook pages associated with the connected account
      def fb_get_pages(location_id: nil, fetch_existing: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/pages",
          security: ["bearer"],
          params: { "locationId" => location_id, "fetchExisting" => fetch_existing }.compact
        )
      end

      # Get Instagram accounts for page
      #
      # Retrieve Instagram accounts linked to a specific Facebook page
      def fb_get_instagram_accounts(page_id:, location_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/page/#{page_id}/instagram",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact
        )
      end

      # Get page lead forms
      #
      # Retrieve lead gen forms for a specific Facebook page
      def fb_get_page_lead_forms(page_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/page/#{page_id}/forms",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create page lead form
      #
      # Create a new lead gen form on a Facebook page
      def fb_create_page_lead_form(page_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/page/#{page_id}/forms",
          security: ["bearer"],
          body: body
        )
      end

      # Get ad accounts
      #
      # Retrieve Facebook ad accounts available for the connected user
      def fb_get_ad_accounts(location_id: nil, type: nil, next_: nil, fetch_all: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/ad-accounts",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "next" => next_, "fetchAll" => fetch_all, "limit" => limit }.compact
        )
      end

      # Get ad account details
      #
      # Retrieve details of a specific Facebook ad account
      def fb_get_ad_account(ad_account_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/ad-accounts/#{ad_account_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Delete ad account
      #
      # Remove a Facebook ad account connection from a location
      def fb_delete_ad_account(ad_account_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/ad-accounts/#{ad_account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get conversation forms
      #
      # Retrieve Facebook conversation lead forms for a location
      def fb_get_conversation_forms(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/conversation-forms",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create conversation form
      #
      # Create a new Facebook conversation lead form
      def fb_create_conversation_form(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/conversation-forms",
          security: ["bearer"],
          body: body
        )
      end

      # Get Facebook integration
      #
      # Retrieve the Facebook ad integration details for a location
      def fb_get_integration(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/integration",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Facebook integration
      #
      # Create a Facebook ad integration for a location with page and ad account
      def fb_create_integration(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/integration",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Facebook integration
      #
      # Remove the Facebook ad integration from a location
      def fb_delete_integration(body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/integration",
          security: ["bearer"],
          body: body
        )
      end

      # Search targeting options
      #
      # Search Facebook geo-locations and interests for ad targeting
      def fb_search_targeting(type: nil, query: nil, search_type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/targeting/search",
          security: ["bearer"],
          params: { "type" => type, "query" => query, "searchType" => search_type }.compact
        )
      end

      # Publish campaign
      #
      # Publish a Facebook campaign and push it live to Facebook
      def fb_publish_campaign(campaign_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/campaigns/#{campaign_id}/publish",
          security: ["bearer"],
          body: body
        )
      end

      # Delete page connection
      #
      # Remove a Facebook page connection from a location
      def fb_delete_page(location_id: nil, page_id: nil, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/page",
          security: ["bearer"],
          params: { "locationId" => location_id, "pageId" => page_id }.compact
        )
      end

      # Get conversion pixels
      #
      # Retrieve Facebook conversion pixels for a location
      def fb_get_pixels(location_id: nil, channel: nil, page_id: nil, ig_user_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/pixels",
          security: ["bearer"],
          params: { "locationId" => location_id, "channel" => channel, "pageId" => page_id, "igUserId" => ig_user_id }.compact
        )
      end

      # Upsert conversion pixel
      #
      # Create or update a Facebook conversion pixel configuration
      def fb_upsert_pixel(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/pixels",
          security: ["bearer"],
          body: body
        )
      end

      # Get custom audiences
      #
      # Retrieve Facebook custom audiences for a location
      def fb_get_custom_audiences(location_id: nil, type: nil, source: nil, ad_account_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/custom-audience",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "source" => source, "adAccountId" => ad_account_id }.compact
        )
      end

      # Get custom audience by ID
      #
      # Retrieve a specific Facebook custom audience by its ID
      def fb_get_custom_audience_by_id(audience_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Update custom audience
      #
      # Update name or description of a Facebook custom audience
      def fb_update_custom_audience(audience_id:, body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete custom audience
      #
      # Delete a Facebook custom audience by ID
      def fb_delete_custom_audience(audience_id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Add custom audience member
      #
      # Add a member to a Facebook custom audience
      def fb_add_custom_audience_member(audience_id:, body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}/member",
          security: ["bearer"],
          body: body
        )
      end

      # Remove custom audience member
      #
      # Remove a member from a Facebook custom audience
      def fb_remove_custom_audience_member(audience_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}/member",
          security: ["bearer"],
          body: body
        )
      end

      # Batch update audience members
      #
      # Add or remove members in bulk from a Facebook custom audience via CSV or smart lists
      def fb_batch_update_audience_members(audience_id:, body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/custom-audience/#{audience_id}/member/batch",
          security: ["bearer"],
          body: body
        )
      end

      # Set default page
      #
      # Set the default Facebook page for a location
      def fb_set_default_page(body:, location_id: nil, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/page/default",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Get lead form by ID
      #
      # Retrieve a specific Facebook lead form by its ID
      def fb_get_lead_form(lead_form_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/lead-form/#{lead_form_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get campaign with linked entities
      #
      # Retrieve a Facebook campaign with its linked adsets and ads
      def fb_get_campaign(campaign_id:, location_id: nil, fields: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/campaign/#{campaign_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "fields" => fields, "source" => source }.compact
        )
      end

      # Get entities
      #
      # Retrieve Facebook campaigns, adsets, or ads based on entity type
      def fb_get_entity(location_id: nil, type: nil, next_: nil, fetch_all: nil, campaign_id: nil, ad_set_id: nil, entity_type: nil, search_id: nil, selected_ad_account_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/facebook/entity",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "next" => next_, "fetchAll" => fetch_all, "campaignId" => campaign_id, "adSetId" => ad_set_id, "entityType" => entity_type, "searchId" => search_id, "selectedAdAccountId" => selected_ad_account_id }.compact
        )
      end

      # Upsert campaign
      #
      # Create or update a Facebook campaign
      def fb_upsert_campaign(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/campaigns",
          security: ["bearer"],
          body: body
        )
      end

      # Upsert adset
      #
      # Create or update a Facebook ad set
      def fb_upsert_adset(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/adsets",
          security: ["bearer"],
          body: body
        )
      end

      # Upsert ad
      #
      # Create or update a Facebook ad (v2)
      def fb_upsert_ad(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/facebook/ads-v2",
          security: ["bearer"],
          body: body
        )
      end

      # Pause campaign
      #
      # Pause a running Facebook campaign
      def fb_pause_campaign(campaign_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/campaigns/#{campaign_id}/pause",
          security: ["bearer"],
          body: body
        )
      end

      # Resume campaign
      #
      # Resume a paused Facebook campaign
      def fb_resume_campaign(campaign_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/campaigns/#{campaign_id}/resume",
          security: ["bearer"],
          body: body
        )
      end

      # Duplicate campaign
      #
      # Duplicate an existing Facebook campaign
      def fb_duplicate_campaign(campaign_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/campaigns/#{campaign_id}/duplicate",
          security: ["bearer"],
          body: body
        )
      end

      # Delete campaign
      #
      # Delete a Facebook campaign by ID
      def fb_delete_campaign(campaign_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/campaigns/#{campaign_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Pause ad set
      #
      # Pause a running Facebook ad set
      def fb_pause_adset(adset_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/adsets/#{adset_id}/pause",
          security: ["bearer"],
          body: body
        )
      end

      # Resume ad set
      #
      # Resume a paused Facebook ad set
      def fb_resume_adset(adset_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/adsets/#{adset_id}/resume",
          security: ["bearer"],
          body: body
        )
      end

      # Duplicate ad set
      #
      # Duplicate an existing Facebook ad set
      def fb_duplicate_adset(adset_id:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/adsets/#{adset_id}/duplicate",
          security: ["bearer"]
        )
      end

      # Delete ad set
      #
      # Delete a Facebook ad set by ID
      def fb_delete_adset(adset_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/adsets/#{adset_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Pause ad
      #
      # Pause a running Facebook ad
      def fb_pause_ad(ad_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/ads/#{ad_id}/pause",
          security: ["bearer"],
          body: body
        )
      end

      # Resume ad
      #
      # Resume a paused Facebook ad
      def fb_resume_ad(ad_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/ads/#{ad_id}/resume",
          security: ["bearer"],
          body: body
        )
      end

      # Duplicate ad
      #
      # Duplicate an existing Facebook ad
      def fb_duplicate_ad(ad_id:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/facebook/ads/#{ad_id}/duplicate",
          security: ["bearer"]
        )
      end

      # Delete ad
      #
      # Delete a Facebook ad by ID
      def fb_delete_ad(ad_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/facebook/ads/#{ad_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Get reporting data
      #
      # Retrieve aggregated Google Ads reporting metrics for a location
      def google_get_reporting(location_id: nil, group_by: nil, start_date: nil, end_date: nil, type: nil, fields: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/reporting",
          security: ["bearer"],
          params: { "locationId" => location_id, "groupBy" => group_by, "startDate" => start_date, "endDate" => end_date, "type" => type, "fields" => fields }.compact
        )
      end

      # Get reporting list
      #
      # Retrieve a list of Google campaigns or ad groups with reporting data
      def google_get_reporting_list(location_id: nil, list_type: nil, start_date: nil, end_date: nil, campaign_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/reporting/list",
          security: ["bearer"],
          params: { "locationId" => location_id, "listType" => list_type, "startDate" => start_date, "endDate" => end_date, "campaignId" => campaign_id, "type" => type }.compact
        )
      end

      # Get campaign reporting
      #
      # Retrieve reporting metrics for a specific Google campaign
      def google_get_campaign_reporting(campaign_id:, location_id: nil, start_date: nil, end_date: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/reporting/campaign/#{campaign_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "startDate" => start_date, "endDate" => end_date }.compact
        )
      end

      # Get conversions
      #
      # Retrieve Google Ads conversion actions for a location
      def google_get_conversions(location_id: nil, type: nil, conversion_type: nil, category: nil, start_date: nil, end_date: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/conversions",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "conversionType" => conversion_type, "category" => category, "startDate" => start_date, "endDate" => end_date }.compact
        )
      end

      # Upsert conversion
      #
      # Create or update a Google Ads conversion action
      def google_upsert_conversion(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/google/conversions",
          security: ["bearer"],
          body: body
        )
      end

      # Get conversion by ID
      #
      # Retrieve a specific Google Ads conversion action by ID
      def google_get_conversion_by_id(conversion_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/conversions/#{conversion_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Delete conversion
      #
      # Delete a Google Ads conversion action by ID
      def google_delete_conversion(conversion_id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/google/conversions/#{conversion_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get Google integration
      #
      # Retrieve the Google Ads integration details for a location
      def google_get_integration(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/integration",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Google integration
      #
      # Create a Google Ads integration for a location
      def google_create_integration(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/google/integration",
          security: ["bearer"],
          body: body
        )
      end

      # Get current Google user
      #
      # Retrieve the authenticated Google user info for a location
      def google_get_current_user(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/me",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get Google ad accounts
      #
      # Retrieve Google Ads accounts available for the connected user
      def google_get_ad_accounts(location_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/ad-accounts",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact
        )
      end

      # Get ad account details
      #
      # Retrieve details of a specific Google Ads account
      def google_get_ad_account_details(ad_account_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/ad-accounts/#{ad_account_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Delete ad account
      #
      # Remove a Google Ads account connection from a location
      def google_delete_ad_account(ad_account_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/google/ad-accounts/#{ad_account_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Publish ad
      #
      # Publish a Google ad and push it live
      def google_publish_ad(ad_id:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/google/ads/#{ad_id}/publish",
          security: ["bearer"]
        )
      end

      # Search targeting options
      #
      # Search Google geo-locations for ad targeting
      def google_search_targeting(type: nil, query: nil, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/targeting/search",
          security: ["bearer"],
          params: { "type" => type, "query" => query, "locationId" => location_id }.compact
        )
      end

      # Get keyword ideas
      #
      # Retrieve keyword suggestions for Google Ads campaigns
      def google_get_keyword_ideas(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/google/keyword-ideas",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Get assets
      #
      # Retrieve Google Ads creative assets for a location
      def google_get_assets(location_id: nil, type: nil, id: nil, advertiser_only: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/assets",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "id" => id, "advertiserOnly" => advertiser_only }.compact
        )
      end

      # Upsert assets
      #
      # Create or update Google Ads creative assets
      def google_upsert_assets(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/google/assets",
          security: ["bearer"],
          body: body
        )
      end

      # Get entities
      #
      # Retrieve Google campaigns, ad groups, or ads based on entity type
      def google_get_entity(location_id: nil, type: nil, campaign_id: nil, ad_group_id: nil, entity_type: nil, search_id: nil, start_date: nil, end_date: nil, selected_ad_account_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/entity",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "campaignId" => campaign_id, "adGroupId" => ad_group_id, "entityType" => entity_type, "searchId" => search_id, "startDate" => start_date, "endDate" => end_date, "selectedAdAccountId" => selected_ad_account_id }.compact
        )
      end

      # Get target interests
      #
      # Retrieve affinity and in-market audience options for Google Ads targeting
      def google_get_target_interests(location_id: nil, type: nil, advertising_channel_type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/target-interests",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type, "advertisingChannelType" => advertising_channel_type }.compact
        )
      end

      # Get segments
      #
      # Retrieve Google Ads audience segments for a location
      def google_get_segments(location_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/segments",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact
        )
      end

      # Upsert segment
      #
      # Create or update a Google Ads audience segment
      def google_upsert_segment(body:, location_id: nil, type: nil, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/google/segments",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact,
          body: body
        )
      end

      # Get segment by ID
      #
      # Retrieve a specific Google Ads audience segment by ID
      def google_get_segment_by_id(segment_id:, location_id: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/segments/#{segment_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact
        )
      end

      # Delete segment
      #
      # Delete a Google Ads audience segment by ID
      def google_delete_segment(segment_id:, location_id: nil, type: nil, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/google/segments/#{segment_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "type" => type }.compact
        )
      end

      # Create offline user list job
      #
      # Create a job to upload users to a Google customer match list
      def google_create_offline_user_list_job(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/google/segments/offline-user-list-job",
          security: ["bearer"],
          body: body
        )
      end

      # Get audiences
      #
      # Retrieve Google Ads combined audiences for a location
      def google_get_audiences(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/audiences",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Upsert audience
      #
      # Create or update a Google Ads combined audience
      def google_upsert_audience(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/google/audiences",
          security: ["bearer"],
          body: body
        )
      end

      # Get audience by ID
      #
      # Retrieve a specific Google Ads combined audience by ID
      def google_get_audience_by_id(audience_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/audiences/#{audience_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Upsert Google campaign
      #
      # Create or update a full Google Ads campaign structure
      def google_upsert_campaign(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/google/ads",
          security: ["bearer"],
          body: body
        )
      end

      # Get Google campaign by ID
      #
      # Retrieve a specific Google Ads campaign by ID
      def google_get_campaign_by_id(ad_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/ads/#{ad_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get conversion goals
      #
      # Retrieve Google Ads conversion goals for a location
      def google_get_conversion_goals(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/google/conversion-goals",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get LinkedIn integration
      #
      # Retrieve the LinkedIn Ads integration details for a location
      def li_get_integration(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/integration",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create LinkedIn integration
      #
      # Create a LinkedIn Ads integration for a location with ad account details
      def li_create_integration(body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/linkedin/integration",
          security: ["bearer"],
          body: body
        )
      end

      # Get LinkedIn ad accounts
      #
      # Retrieve LinkedIn Ads accounts available for the connected user
      def li_get_ad_accounts(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/ad-accounts",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get ad account details
      #
      # Retrieve details of a specific LinkedIn ad account
      def li_get_ad_account_details(location_id: nil, ad_account_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/ad-account",
          security: ["bearer"],
          params: { "locationId" => location_id, "adAccountId" => ad_account_id }.compact
        )
      end

      # Delete ad account
      #
      # Remove a LinkedIn ad account connection from a location
      def li_delete_ad_account(location_id: nil, ad_account_id: nil, **_opts)
        request(
          method: :delete,
          path: "/ad-publishing/linkedin/ad-account",
          security: ["bearer"],
          params: { "locationId" => location_id, "adAccountId" => ad_account_id }.compact
        )
      end

      # Get current LinkedIn user
      #
      # Retrieve the authenticated LinkedIn user info for a location
      def li_get_current_user(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/me",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get ad campaign group
      #
      # Retrieve a LinkedIn ad campaign group by ID
      def li_get_campaign_group(ad_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/ads/#{ad_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Publish ad campaign group
      #
      # Publish a LinkedIn ad campaign group and push it live
      def li_publish_campaign_group(ad_id:, body:, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/linkedin/ads/#{ad_id}/publish",
          security: ["bearer"],
          body: body
        )
      end

      # Upsert ad campaign group
      #
      # Create or update a LinkedIn ad campaign group with campaigns and ads
      def li_upsert_campaign_group(body:, **_opts)
        request(
          method: :put,
          path: "/ad-publishing/linkedin/ads",
          security: ["bearer"],
          body: body
        )
      end

      # Search targeting options
      #
      # Search LinkedIn targeting facets such as locations, industries, and job titles
      def li_search_targeting(location_id: nil, facet: nil, query: nil, q: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/targeting/search",
          security: ["bearer"],
          params: { "locationId" => location_id, "facet" => facet, "query" => query, "q" => q }.compact
        )
      end

      # Get lead forms
      #
      # Retrieve LinkedIn lead gen forms for an ad account
      def li_get_lead_forms(account_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/#{account_id}/forms",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create lead form
      #
      # Create a new LinkedIn lead gen form for an ad account
      def li_create_lead_form(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/ad-publishing/linkedin/#{account_id}/form",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Update ad status
      #
      # Pause or resume a LinkedIn ad, campaign, or ad group
      def li_update_ad_status(ad_id:, body:, location_id: nil, **_opts)
        request(
          method: :patch,
          path: "/ad-publishing/linkedin/#{ad_id}/status",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Get ad analytics
      #
      # Retrieve LinkedIn Ads analytics data with configurable pivot and time grouping
      def li_get_ad_analytics(location_id: nil, pivot: nil, group_by: nil, start_date: nil, end_date: nil, entity_urns: nil, fields: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/reporting",
          security: ["bearer"],
          params: { "locationId" => location_id, "pivot" => pivot, "groupBy" => group_by, "startDate" => start_date, "endDate" => end_date, "entityUrns" => entity_urns, "fields" => fields }.compact
        )
      end

      # Get reporting list
      #
      # Retrieve a list of LinkedIn campaigns or campaign groups with reporting data
      def li_get_reporting_list(location_id: nil, list_type: nil, campaign_id: nil, campaign_group_id: nil, start_date: nil, end_date: nil, fields: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/reporting/list",
          security: ["bearer"],
          params: { "locationId" => location_id, "listType" => list_type, "campaignId" => campaign_id, "campaignGroupId" => campaign_group_id, "startDate" => start_date, "endDate" => end_date, "fields" => fields }.compact
        )
      end

      # Get campaign group reporting
      #
      # Retrieve reporting metrics for a specific LinkedIn campaign group
      def li_get_campaign_group_reporting(campaign_group_id:, location_id: nil, start_date: nil, end_date: nil, fields: nil, **_opts)
        request(
          method: :get,
          path: "/ad-publishing/linkedin/reporting/campaign-group/#{campaign_group_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "startDate" => start_date, "endDate" => end_date, "fields" => fields }.compact
        )
      end
    end
  end
end
