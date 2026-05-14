# frozen_string_literal: true

require "active_record"
require "json"

module HighLevel
  module Storage
    # ActiveRecord-backed session storage. Designed for Rails apps with
    # an existing database connection — the gem ships the model class
    # plus a migration helper; the user adds the migration to their
    # `db/migrate/` directory and runs `rake db:migrate`.
    #
    # Schema:
    #   gohighlevel_sessions(application_id, resource_id, payload TEXT,
    #                        expire_at DATETIME, created_at, updated_at)
    # with a unique index on (application_id, resource_id).
    class ActiveRecord < Base
      TABLE_NAME = "gohighlevel_sessions"

      # Persisted session row. Stored as a plain JSON string in `payload`
      # to keep the schema portable across SQL backends.
      class Session < ::ActiveRecord::Base
        self.table_name = TABLE_NAME
      end

      # `bin/rails g migration AddGohighlevelSessions` and paste the
      # `change` block below — or call `Migration.create_table!(connection)`
      # at boot in non-Rails apps.
      module Migration
        module_function

        def create_table!(connection = ::ActiveRecord::Base.connection)
          return if connection.table_exists?(TABLE_NAME)

          connection.create_table(TABLE_NAME) do |t|
            t.string :application_id, null: false
            t.string :resource_id, null: false
            t.text :payload, null: false
            t.datetime :expire_at
            t.timestamps
          end
          connection.add_index TABLE_NAME, %i[application_id resource_id], unique: true
        end
      end

      def initialize(model: Session)
        super()
        @model = model
        @client_id = nil
      end

      def init
        # No-op — assumes the user has run the migration.
      end

      def disconnect
        # No-op — AR pools are managed by the host app.
      end

      def set_client_id(client_id)
        raise ArgumentError, "client_id is required" if client_id.nil? || client_id.to_s.empty?

        @client_id = client_id.to_s
      end

      def set_session(resource_id, session_data)
        data = symbolize_keys(session_data)
        document = data.merge(expire_at: calculate_expire_at(data[:expires_in]))

        record = @model.find_or_initialize_by(application_id: application_id, resource_id: resource_id)
        record.payload = JSON.generate(document)
        record.expire_at = Time.at(document[:expire_at] / 1000.0)
        record.save!
        nil
      end

      def get_session(resource_id)
        row = @model.find_by(application_id: application_id, resource_id: resource_id)
        return nil if row.nil?

        JSON.parse(row.payload, symbolize_names: true)
      end

      def get_access_token(resource_id)
        session = get_session(resource_id)
        session && session[:access_token]
      end

      def delete_session(resource_id)
        @model.where(application_id: application_id, resource_id: resource_id).delete_all
        nil
      end

      private

      def application_id
        return "default" if @client_id.nil? || @client_id.empty?

        @client_id.split("-").first
      end

      def symbolize_keys(hash)
        return {} if hash.nil?

        hash.transform_keys(&:to_sym)
      end
    end
  end
end
