# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Conversations < Base
      # Search Conversations
      #
      # Returns a list of all conversations matching the search criteria along with the sort and filter options selected.
      def search_conversation(location_id: nil, contact_id: nil, assigned_to: nil, followers: nil, mentions: nil, query: nil, sort: nil, start_after_date: nil, id: nil, limit: nil, last_message_type: nil, last_message_action: nil, last_message_direction: nil, status: nil, sort_by: nil, sort_score_profile: nil, score_profile: nil, score_profile_min: nil, score_profile_max: nil, start_date: nil, end_date: nil, **_opts)
        request(
          method: :get,
          path: "/conversations/search",
          security: ["bearer"],
          params: { "locationId" => location_id, "contactId" => contact_id, "assignedTo" => assigned_to, "followers" => followers, "mentions" => mentions, "query" => query, "sort" => sort, "startAfterDate" => start_after_date, "id" => id, "limit" => limit, "lastMessageType" => last_message_type, "lastMessageAction" => last_message_action, "lastMessageDirection" => last_message_direction, "status" => status, "sortBy" => sort_by, "sortScoreProfile" => sort_score_profile, "scoreProfile" => score_profile, "scoreProfileMin" => score_profile_min, "scoreProfileMax" => score_profile_max, "startDate" => start_date, "endDate" => end_date }.compact
        )
      end

      # Get Conversation
      #
      # Get the conversation details based on the conversation ID
      def get_conversation(conversation_id:, **_opts)
        request(
          method: :get,
          path: "/conversations/#{conversation_id}",
          security: ["bearer"]
        )
      end

      # Update Conversation
      #
      # Update the conversation details based on the conversation ID
      def update_conversation(conversation_id:, body:, **_opts)
        request(
          method: :put,
          path: "/conversations/#{conversation_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Conversation
      #
      # Delete the conversation details based on the conversation ID
      def delete_conversation(conversation_id:, **_opts)
        request(
          method: :delete,
          path: "/conversations/#{conversation_id}",
          security: ["bearer"]
        )
      end

      # Get All Custom Subtypes
      #
      # Get all custom subtypes for a location
      def get_all_custom_subtypes(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/conversations/preferences/custom-subtypes",
          security: [],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Custom Subtype
      #
      # Create a new custom subtype for a location. Requires agency or account admin role.
      def create_custom_subtype(body:, location_id: nil, **_opts)
        request(
          method: :post,
          path: "/conversations/preferences/custom-subtypes",
          security: [],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Update Custom Subtype
      #
      # Update or archive a custom subtype. Requires agency or account admin role.
      def update_custom_subtype(id:, body:, location_id: nil, **_opts)
        request(
          method: :put,
          path: "/conversations/preferences/custom-subtypes/#{id}",
          security: [],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Get Contact Unsubscription Status
      #
      # Get all subscription statuses for a contact (all emails or specific email)
      def get_contact_unsubscription_status(location_id: nil, contact_id: nil, email: nil, **_opts)
        request(
          method: :get,
          path: "/conversations/preferences/unsubscriptions/status",
          security: [],
          params: { "locationId" => location_id, "contactId" => contact_id, "email" => email }.compact
        )
      end

      # User Subscription Change
      #
      # Process subscription change initiated by a user (admin/agent). Supports individual custom subscription changes and resub all functionality. Legal forms are automatically created for user-initiated resubscribe actions on custom subscriptions.
      def user_subscription_change(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/preferences/unsubscriptions/user-change",
          security: [],
          body: body
        )
      end

      # Get email by Id
      def get_email_by_id(**_opts)
        request(
          method: :get,
          path: "/conversations/messages/email/#{id}",
          security: []
        )
      end

      # Cancel a scheduled email message.
      #
      # Post the messageId for the API to delete a scheduled email message. <br />
      def cancel_scheduled_email_message(email_message_id:, **_opts)
        request(
          method: :delete,
          path: "/conversations/messages/email/#{email_message_id}/schedule",
          security: []
        )
      end

      # Export messages by location ID
      #
      # Export messages for a specific location with cursor-based pagination support. Response includes messageType (string), source, and subType fields. The channel parameter is optional - if not provided, all non-email message types will be returned including activity messages (opportunity updates, appointments, etc.).
      def export_messages_by_location(location_id: nil, limit: nil, cursor: nil, sort_by: nil, sort_order: nil, conversation_id: nil, contact_id: nil, channel: nil, start_date: nil, end_date: nil, **_opts)
        request(
          method: :get,
          path: "/conversations/messages/export",
          security: ["bearer"],
          params: { "locationId" => location_id, "limit" => limit, "cursor" => cursor, "sortBy" => sort_by, "sortOrder" => sort_order, "conversationId" => conversation_id, "contactId" => contact_id, "channel" => channel, "startDate" => start_date, "endDate" => end_date }.compact
        )
      end

      # Get message by message id
      #
      # Get message by message id.
      def get_message(**_opts)
        request(
          method: :get,
          path: "/conversations/messages/#{id}",
          security: ["bearer"]
        )
      end

      # Get messages by conversation id
      #
      # Get messages by conversation id.
      def get_messages(conversation_id:, last_message_id: nil, limit: nil, type: nil, **_opts)
        request(
          method: :get,
          path: "/conversations/#{conversation_id}/messages",
          security: ["bearer"],
          params: { "lastMessageId" => last_message_id, "limit" => limit, "type" => type }.compact
        )
      end

      # Send a new message
      #
      # Post the necessary fields for the API to send a new message.
      def send_a_new_message(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages",
          security: ["bearer"],
          body: body
        )
      end

      # Add an inbound message
      #
      # Post the necessary fields for the API to add a new inbound message. <br />
      def add_an_inbound_message(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/inbound",
          security: ["bearer"],
          body: body
        )
      end

      # Add an external outbound call
      #
      # Post the necessary fields for the API to add a new outbound call.
      def add_an_outbound_message(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/outbound",
          security: ["bearer"],
          body: body
        )
      end

      # Send a review reply to Google My Business
      #
      # Post a reply to a customer review on Google My Business
      def send_review_reply(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/review-reply",
          security: ["bearer"],
          body: body
        )
      end

      # Cancel a scheduled message.
      #
      # Post the messageId for the API to delete a scheduled message. <br />
      def cancel_scheduled_message(message_id:, **_opts)
        request(
          method: :delete,
          path: "/conversations/messages/#{message_id}/schedule",
          security: ["bearer"]
        )
      end

      # Upload file attachments
      #
      # Post the necessary fields for the API to upload files. The files need to be a buffer with the key "fileAttachment". <br /><br /> The allowed file types are: <br/> <ul><li>JPG</li><li>JPEG</li><li>PNG</li><li>MP4</li><li>MPEG</li><li>ZIP</li><li>RAR</li><li>PDF</li><li>DOC</li><li>DOCX</li><li>TXT</li><li>MP3</li><li>WAV</li></ul> <br /><br /> The API will return an object with the URLs
      def upload_file_attachments(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/upload",
          security: ["bearer"],
          body: body
        )
      end

      # Initiate file upload to GCS
      #
      # Generates a signed URL for direct file upload to Google Cloud Storage. Returns a signed URL valid for 15 minutes. Upload file via PUT request, then call /complete to finalize.
      def initiate_file_upload(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/upload/initiate",
          security: ["bearer"],
          body: body
        )
      end

      # Complete file upload
      #
      # Validates the uploaded file in GCS and returns the public URL. Call this endpoint after successfully uploading the file to the signed URL.
      def complete_file_upload(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/messages/upload/complete",
          security: ["bearer"],
          body: body
        )
      end

      # Update message status
      #
      # Post the necessary fields for the API to update message status.
      def update_message_status(message_id:, body:, **_opts)
        request(
          method: :put,
          path: "/conversations/messages/#{message_id}/status",
          security: ["bearer"],
          body: body
        )
      end

      # Add message attachments
      #
      # Set attachments on an existing message (replaces existing). Maximum 5 URLs. Supported for TYPE_CUSTOM_CALL (34) and TYPE_CALL (1) with subType EXTERNAL_CALL.
      def add_message_attachments(message_id:, body:, **_opts)
        request(
          method: :put,
          path: "/conversations/messages/#{message_id}/attachments",
          security: ["bearer"],
          body: body
        )
      end

      # Get Recording by Message ID
      #
      # Get the recording for a message by passing the message id
      def get_message_recording(location_id:, message_id:, **_opts)
        request(
          method: :get,
          path: "/conversations/messages/#{message_id}/locations/#{location_id}/recording",
          security: %w[bearer Location-Access]
        )
      end

      # Get transcription by Message ID
      #
      # Get the recording transcription for a message by passing the message id
      def get_message_transcription(location_id:, message_id:, **_opts)
        request(
          method: :get,
          path: "/conversations/locations/#{location_id}/messages/#{message_id}/transcription",
          security: %w[bearer Location-Access]
        )
      end

      # Download transcription by Message ID
      #
      # Download the recording transcription for a message by passing the message id
      def download_message_transcription(location_id:, message_id:, **_opts)
        request(
          method: :get,
          path: "/conversations/locations/#{location_id}/messages/#{message_id}/transcription/download",
          security: %w[bearer Location-Access]
        )
      end

      # Agent/Ai-Bot is typing a message indicator for live chat
      #
      # Agent/AI-Bot will call this when they are typing a message in live chat message
      def live_chat_agent_typing(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/providers/live-chat/typing",
          security: ["Location-Access"],
          body: body
        )
      end

      # Create Conversation
      #
      # Creates a new conversation with the data provided
      def create_conversation(body:, **_opts)
        request(
          method: :post,
          path: "/conversations/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
