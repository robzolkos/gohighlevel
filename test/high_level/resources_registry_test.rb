# frozen_string_literal: true

require "test_helper"

module HighLevel
  class ResourceRegistryTest < Minitest::Test
    def setup
      @client = Client.new(private_integration_token: "pit-xyz")
    end

    # Hand-written apps live outside the registry — see Generator::SKIP_APPS.
    HAND_WRITTEN_APPS = %i[oauth].freeze

    def test_registry_covers_every_spec_under_vendor_openapi
      spec_apps = Dir.glob(File.expand_path("../../vendor/openapi/apps/*.json", __dir__))
                     .map { |p| File.basename(p, ".json").tr("-", "_").to_sym }
                     .reject { |s| HAND_WRITTEN_APPS.include?(s) }

      assert_equal spec_apps.sort, RESOURCE_REGISTRY.keys.sort
    end

    def test_every_registered_resource_subclasses_resources_base
      RESOURCE_REGISTRY.each_value do |klass|
        assert_operator klass, :<, Resources::Base, "#{klass} should inherit from Resources::Base"
      end
    end

    def test_client_method_missing_dispatches_to_registry
      RESOURCE_REGISTRY.each do |name, klass|
        assert @client.respond_to?(name), "client should respond_to(#{name})"
        assert_instance_of klass, @client.public_send(name)
      end
    end

    def test_resource_accessors_are_memoized
      first = @client.contacts
      second = @client.contacts
      assert_same first, second
    end

    def test_every_resource_exposes_at_least_one_public_method
      RESOURCE_REGISTRY.each_value do |klass|
        public_methods = klass.public_instance_methods(false)
        assert_operator public_methods.length, :>, 0,
                        "#{klass} should expose at least one generated method"
      end
    end
  end
end
