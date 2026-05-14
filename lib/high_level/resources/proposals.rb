# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/proposals.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Proposals < Base
      # List documents
      #
      # List documents for a location
      def list_documents_contracts(location_id: nil, status: nil, payment_status: nil, limit: nil, skip: nil, query: nil, date_from: nil, date_to: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/proposals/document",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id, "status" => status, "paymentStatus" => payment_status, "limit" => limit, "skip" => skip, "query" => query, "dateFrom" => date_from, "dateTo" => date_to }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Send document
      #
      # Send document to a client
      def send_documents_contracts(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/proposals/document/send",
          security: %w[Location-Access Agency-Access],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end

      # List templates
      #
      # List document contract templates for a location
      def list_documents_contracts_templates(location_id: nil, date_from: nil, date_to: nil, type: nil, name: nil, is_public_document: nil, user_id: nil, limit: nil, skip: nil, authorization: nil, **_opts)
        request(
          method: :get,
          path: "/proposals/templates",
          security: %w[Location-Access Agency-Access],
          params: { "locationId" => location_id, "dateFrom" => date_from, "dateTo" => date_to, "type" => type, "name" => name, "isPublicDocument" => is_public_document, "userId" => user_id, "limit" => limit, "skip" => skip }.compact,
          headers: { "Authorization" => authorization }.compact
        )
      end

      # Send template
      #
      # Send template to a client
      def send_documents_contracts_template(body:, authorization: nil, **_opts)
        request(
          method: :post,
          path: "/proposals/templates/send",
          security: %w[Location-Access Agency-Access],
          headers: { "Authorization" => authorization }.compact,
          body: body
        )
      end
    end
  end
end
