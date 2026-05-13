# frozen_string_literal: true

require "test_helper"

module HighLevel
  class ConfigurationTest < Minitest::Test
    def test_defaults_api_version
      assert_equal "2021-07-28", Configuration.new.api_version
    end

    def test_defaults_base_url
      assert_equal "https://services.leadconnectorhq.com", Configuration.new.base_url
    end

    def test_round_trips_private_integration_token
      config = Configuration.new(private_integration_token: "pit-xyz")
      assert_equal "pit-xyz", config.private_integration_token
    end

    def test_is_immutable
      config = Configuration.new(private_integration_token: "pit-xyz")
      assert_raises(NoMethodError) { config.private_integration_token = "other" }
    end

    def test_value_equality
      storage = Storage::Memory.new
      a = Configuration.new(private_integration_token: "x", session_storage: storage)
      b = Configuration.new(private_integration_token: "x", session_storage: storage)
      assert_equal a, b
    end

    def test_session_storage_defaults_to_a_fresh_memory_per_instance
      a = Configuration.new
      b = Configuration.new

      assert_instance_of Storage::Memory, a.session_storage
      refute_same a.session_storage, b.session_storage
    end

    def test_credential_fields_default_to_nil
      config = Configuration.new
      assert_nil config.private_integration_token
      assert_nil config.agency_access_token
      assert_nil config.location_access_token
      assert_nil config.client_id
      assert_nil config.client_secret
    end
  end
end
