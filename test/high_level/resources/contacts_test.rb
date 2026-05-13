# frozen_string_literal: true

require "test_helper"

module HighLevel
  module Resources
    class ContactsSmokeTest < Minitest::Test
      BASE = "https://services.leadconnectorhq.com"

      def setup
        @client = Client.new(private_integration_token: "pit-xyz")
      end

      def test_client_contacts_returns_a_resources_contacts_instance
        assert_instance_of Resources::Contacts, @client.contacts
        assert_same @client.contacts, @client.contacts # memoized
      end

      def test_search_contacts_advanced_posts_with_correct_path_and_body
        stub_request(:post, "#{BASE}/contacts/search")
          .with(
            body: { locationId: "loc-1", pageLimit: 20 }.to_json,
            headers: { "Authorization" => "Bearer pit-xyz", "Version" => "2021-07-28" }
          )
          .to_return(
            status: 200,
            body: '{"contacts":[]}',
            headers: { "Content-Type" => "application/json" }
          )

        result = @client.contacts.search_contacts_advanced(
          body: { locationId: "loc-1", pageLimit: 20 }
        )

        assert_equal({ "contacts" => [] }, result)
      end

      def test_path_param_methods_interpolate_correctly
        stub_request(:get, "#{BASE}/contacts/abc-123/tasks")
          .to_return(
            status: 200,
            body: '{"tasks":[]}',
            headers: { "Content-Type" => "application/json" }
          )

        result = @client.contacts.get_all_tasks(contact_id: "abc-123")
        assert_equal({ "tasks" => [] }, result)
      end

      def test_query_param_methods_pass_params
        stub_request(:get, "#{BASE}/contacts/search/duplicate")
          .with(query: { locationId: "loc-1", email: "a@example.com" })
          .to_return(
            status: 200,
            body: '{"contact":null}',
            headers: { "Content-Type" => "application/json" }
          )

        @client.contacts.get_duplicate_contact(
          location_id: "loc-1",
          email: "a@example.com"
        )

        assert_requested :get, "#{BASE}/contacts/search/duplicate",
                         query: { locationId: "loc-1", email: "a@example.com" }
      end

      def test_generated_method_count_matches_spec_operations
        # 32 operations in vendor/openapi/apps/contacts.json — if this drifts,
        # something in the generator changed (or the spec did).
        public_methods = Resources::Contacts.public_instance_methods(false)
        assert_equal 32, public_methods.length
      end

      def test_a_generated_model_exists_and_is_a_data_class
        assert Models::Contacts.const_defined?(:ContactsSearchSchema)
        klass = Models::Contacts::ContactsSearchSchema
        assert_operator klass, :<, Data
      end
    end
  end
end
