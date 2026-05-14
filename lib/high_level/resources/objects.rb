# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/objects.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Objects < Base
      # Get Object Schema by key / id
      #
      # Retrieve Object Schema by key or ID. This will return the schema of the custom object, including all its fields and properties. Supported objects include contact, opportunity, business and custom objects.To understand objects and records, please have a look the documentation here : https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0
      def get_object_schema_by_key(key:, location_id: nil, fetch_properties: nil, **_opts)
        request(
          method: :get,
          path: "/objects/#{key}",
          security: ["bearer"],
          params: { "locationId" => location_id, "fetchProperties" => fetch_properties }.compact
        )
      end

      # Update Object Schema By Key / Id
      #
      # Update Custom Object Schema  or standard object's like contact, opportunity, business searchable fields. To understand objects and records, please have a look at the documentation here : https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0
      def update_custom_object(key:, body:, **_opts)
        request(
          method: :put,
          path: "/objects/#{key}",
          security: ["bearer"],
          body: body
        )
      end

      # Get Record By Id
      #
      # Allows you to get a Standard Object like business and custom object record by Id
      def get_record_by_id(schema_key:, id:, **_opts)
        request(
          method: :get,
          path: "/objects/#{schema_key}/records/#{id}",
          security: ["bearer"]
        )
      end

      # Update Record
      #
      # Update a Custom Object Record by Id. Supported Objects are business and custom objects. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0/87cpx-376296
      def update_object_record(schema_key:, id:, body:, location_id: nil, **_opts)
        request(
          method: :put,
          path: "/objects/#{schema_key}/records/#{id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Delete Record
      #
      # Delete Record By Id . Supported Objects are business and custom objects.
      def delete_object_record(schema_key:, id:, **_opts)
        request(
          method: :delete,
          path: "/objects/#{schema_key}/records/#{id}",
          security: ["bearer"]
        )
      end

      # Create Record
      #
      # Create a Custom Object Record. Supported Objects business and custom objects. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0/87cpx-376296
      def create_object_record(schema_key:, body:, **_opts)
        request(
          method: :post,
          path: "/objects/#{schema_key}/records",
          security: ["bearer"],
          body: body
        )
      end

      # Search Object Records
      #
      # Supported Objects are custom objects and standard objects like "business". Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0/87cpx-379336
      def search_object_records(schema_key:, body:, **_opts)
        request(
          method: :post,
          path: "/objects/#{schema_key}/records/search",
          security: ["bearer"],
          body: body
        )
      end

      # Get all objects for a location
      #
      # Get all objects for a location. Supported Objects are contact, opportunity, business and custom objects.To understand objects and records, please have a look at the documentation here : https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0
      def get_object_by_location_id(location_id: nil, **_opts)
        request(
          method: :get,
          path: "/objects/",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Custom Object
      #
      # Allows you to create a custom object schema. To understand objects and records, please have a look at the documentation here : https://doc.clickup.com/8631005/d/h/87cpx-277156/93bf0c2e23177b0
      def create_custom_object_schema(body:, **_opts)
        request(
          method: :post,
          path: "/objects/",
          security: ["Agency-Access"],
          body: body
        )
      end
    end
  end
end
