# frozen_string_literal: true

require "test_helper"

module HighLevel
  class ResourceRegistryTest < Minitest::Test
    def setup
      @client = Client.new(private_integration_token: "pit-xyz")
    end

    # The registry must agree with the committed generated resource
    # files. We check against committed artifacts rather than
    # vendor/openapi/ — the vendored spec is a build-time input that
    # isn't present in a fresh checkout (or in CI).
    def test_registry_matches_the_committed_resource_files
      resource_files = Dir.glob(File.expand_path("../../lib/high_level/resources/*.rb", __dir__))
                          .map { |p| File.basename(p, ".rb").to_sym }
                          .reject { |name| name == :base }

      assert_equal resource_files.sort, RESOURCE_REGISTRY.keys.sort
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
