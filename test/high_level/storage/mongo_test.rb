# frozen_string_literal: true

require "test_helper"
require_relative "../../support/session_storage_contract"

# Skip Mongo tests entirely if the gem isn't installed (it isn't a dev
# dep). To exercise the backend, install the gem and set MONGO_URL.
mongo_available = begin
  require "mongo"
  true
rescue LoadError
  false
end

if mongo_available && ENV["MONGO_URL"]
  module HighLevel
    module Storage
      class MongoTest < Minitest::Test
        include SessionStorageContract

        def setup
          @client = ::Mongo::Client.new(ENV.fetch("MONGO_URL"))
          @client[Mongo::COLLECTION].drop
          @storage = Mongo.new(client: @client)
          @storage.set_client_id("app-test")
          @storage.init
        end

        def teardown
          @storage.disconnect
        end

        def test_persists_to_the_underlying_collection
          @storage.set_session("res-1", access_token: "tok-1")
          assert_equal 1, @client[Mongo::COLLECTION].count_documents(resource_id: "res-1")
        end
      end
    end
  end
end
