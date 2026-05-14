# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/associations.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Associations < Base
      # Create Relation for you associated entities.
      #
      # Create Relation.Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-293776/cd0f4122abc04d3
      def create_relation(body:, **_opts)
        request(
          method: :post,
          path: "/associations/relations",
          security: ["bearer"],
          body: body
        )
      end

      # Get all relations By record Id
      #
      # Get all relations by record Id
      def get_relations_by_record_id(record_id:, location_id: nil, skip: nil, limit: nil, association_ids: nil, **_opts)
        request(
          method: :get,
          path: "/associations/relations/#{record_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit, "associationIds" => association_ids }.compact
        )
      end

      # Delete Relation
      def delete_relation(relation_id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/associations/relations/#{relation_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get association key by key name
      #
      # Using this api you can get standard / user defined association by key
      def get_association_key_by_key_name(key_name:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/associations/key/#{key_name}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get association by object keys
      #
      # Get association by object keys like contacts, custom objects and opportunities. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-293776/cd0f4122abc04d3
      def get_association_by_object_keys(object_key:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/associations/objectKey/#{object_key}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Get association by ID
      #
      # Using this api you can get SYSTEM_DEFINED / USER_DEFINED association by id
      def get_association_by_id(association_id:, **_opts)
        request(
          method: :get,
          path: "/associations/#{association_id}",
          security: ["bearer"]
        )
      end

      # Update Association By Id
      #
      # Update Association , Allows you to update labels of an associations. Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-293776/cd0f4122abc04d3
      def update_association(association_id:, body:, **_opts)
        request(
          method: :put,
          path: "/associations/#{association_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Association
      #
      # Delete USER_DEFINED Association By Id, deleting an association will also all the relations for that association
      def delete_association(association_id:, **_opts)
        request(
          method: :delete,
          path: "/associations/#{association_id}",
          security: ["bearer"]
        )
      end

      # Get all associations for a sub-account / location
      #
      # Get all Associations
      def find_associations(location_id: nil, skip: nil, limit: nil, **_opts)
        request(
          method: :get,
          path: "/associations/",
          security: ["bearer"],
          params: { "locationId" => location_id, "skip" => skip, "limit" => limit }.compact
        )
      end

      # Create Association
      #
      # Allow you to create contact - contact , contact - custom objects associations, will add more in the future.Documentation Link - https://doc.clickup.com/8631005/d/h/87cpx-293776/cd0f4122abc04d3
      def create_association(body:, **_opts)
        request(
          method: :post,
          path: "/associations/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
