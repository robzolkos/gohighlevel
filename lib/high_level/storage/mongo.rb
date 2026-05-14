# frozen_string_literal: true

require "mongo"

module HighLevel
  module Storage
    # MongoDB-backed session storage. Maintains behavioral parity with
    # the TS SDK's `MongoSessionStorage` (collection name and document
    # shape) so a TS-Ruby polyglot deployment can share a single Mongo
    # store. See vendor/highlevel-api-sdk/lib/storage/mongodb-session-storage.ts.
    #
    # Sessions live in `gohighlevel_sessions` keyed by a compound
    # `{application_id, resource_id}` unique index. `expire_at` carries
    # a TTL index so MongoDB auto-purges expired sessions.
    class Mongo < Base
      # The MongoDB collection name; matches the TS SDK for cross-SDK
      # store sharing.
      COLLECTION = "gohighlevel_sessions"

      # @param client [::Mongo::Client, nil] an existing client, or nil
      #   to build one from +client_options+
      # @param client_options [Hash] +:url+ plus any +::Mongo::Client+ options
      def initialize(client: nil, **client_options)
        super()
        @client = client || ::Mongo::Client.new(client_options[:url] || "mongodb://localhost:27017/gohighlevel",
                                                **client_options.except(:url))
        @client_id = nil
        @indexes_ensured = false
      end

      # (see Base#init)
      def init
        ensure_indexes!
      end

      # (see Base#disconnect)
      def disconnect
        @client.close
      end

      # (see Base#set_client_id)
      def set_client_id(client_id)
        raise ArgumentError, "client_id is required" if client_id.nil? || client_id.to_s.empty?

        @client_id = client_id.to_s
      end

      # (see Base#set_session)
      # rubocop:disable Metrics/MethodLength
      def set_session(resource_id, session_data)
        ensure_indexes!
        data = symbolize_keys(session_data)
        document = data.merge(
          application_id: application_id,
          resource_id: resource_id,
          expire_at: Time.at(calculate_expire_at(data[:expires_in]) / 1000.0),
          updated_at: Time.now
        )

        collection.update_one(
          { application_id: application_id, resource_id: resource_id },
          { "$set" => document, "$setOnInsert" => { created_at: Time.now } },
          upsert: true
        )
        nil
      end
      # rubocop:enable Metrics/MethodLength

      # (see Base#get_session)
      def get_session(resource_id)
        doc = collection.find(application_id: application_id, resource_id: resource_id).first
        return nil if doc.nil?

        symbolize_keys(doc).except(:_id, :application_id, :resource_id, :created_at, :updated_at)
      end

      # (see Base#get_access_token)
      def get_access_token(resource_id)
        session = get_session(resource_id)
        session && session[:access_token]
      end

      # (see Base#delete_session)
      def delete_session(resource_id)
        collection.delete_one(application_id: application_id, resource_id: resource_id)
        nil
      end

      private

      def collection
        @client[COLLECTION]
      end

      def application_id
        return "default" if @client_id.nil? || @client_id.empty?

        @client_id.split("-").first
      end

      def ensure_indexes!
        return if @indexes_ensured

        collection.indexes.create_one({ application_id: 1, resource_id: 1 }, unique: true)
        collection.indexes.create_one({ expire_at: 1 }, expire_after: 0)
        @indexes_ensured = true
      end

      def symbolize_keys(hash)
        return {} if hash.nil?

        hash.transform_keys(&:to_sym)
      end
    end
  end
end
