# frozen_string_literal: true

require "test_helper"
require_relative "../../support/session_storage_contract"
require "active_record"
require "tempfile"

# File-backed SQLite (not `:memory:`) so the contract's concurrent-write
# test can use AR's connection pool — each thread checks out its own
# connection, and SQLite `:memory:` is per-connection.
AR_DB_FILE = Tempfile.create(["gohighlevel_test", ".sqlite3"])
AR_DB_FILE.close
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: AR_DB_FILE.path)
HighLevel::Storage::ActiveRecord::Migration.create_table!

module HighLevel
  module Storage
    class ActiveRecordTest < Minitest::Test
      include SessionStorageContract

      def setup
        ActiveRecord::Session.delete_all
        @storage = ActiveRecord.new
        @storage.set_client_id("app-test")
        @storage.init
      end

      def test_persists_to_the_underlying_table
        @storage.set_session("res-1", access_token: "tok-1")
        assert_equal 1, ActiveRecord::Session.where(resource_id: "res-1").count
      end

      def test_sessions_are_scoped_by_application_id
        # application_id is the first hyphen-separated segment of
        # client_id (parity with the TS SDK + Memory backend). For shared
        # storage we need distinct prefixes to see the scoping.
        @storage.set_session("res-1", access_token: "from-app1")

        other = ActiveRecord.new
        other.set_client_id("app2-other")
        other.init

        assert_nil other.get_session("res-1")
      end

      def test_migration_create_table_is_idempotent
        ActiveRecord::Migration.create_table!
        assert ::ActiveRecord::Base.connection.table_exists?(ActiveRecord::TABLE_NAME)
      end

      def test_set_session_upserts_on_existing_resource_id
        @storage.set_session("res-1", access_token: "first")
        @storage.set_session("res-1", access_token: "second")

        assert_equal 1, ActiveRecord::Session.where(resource_id: "res-1").count
        assert_equal "second", @storage.get_access_token("res-1")
      end
    end
  end
end
