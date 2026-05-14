# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/invoices.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class Invoices < Base
      # List templates
      #
      # API to get list of templates
      def list_invoice_templates(alt_id: nil, alt_type: nil, status: nil, start_at: nil, end_at: nil, search: nil, payment_mode: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/template",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "status" => status, "startAt" => start_at, "endAt" => end_at, "search" => search, "paymentMode" => payment_mode, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Create template
      #
      # API to create a template
      def create_invoice_template(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/template",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Get an template
      #
      # API to get an template by template id
      def get_invoice_template(template_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/template/#{template_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update template
      #
      # API to update an template by template id
      def update_invoice_template(template_id:, body:, **_opts)
        request(
          method: :put,
          path: "/invoices/template/#{template_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete template
      #
      # API to update an template by template id
      def delete_invoice_template(template_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :delete,
          path: "/invoices/template/#{template_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update template late fees configuration
      #
      # API to update template late fees configuration by template id
      def update_invoice_template_late_fees_configuration(template_id:, body:, **_opts)
        request(
          method: :patch,
          path: "/invoices/template/#{template_id}/late-fees-configuration",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Update template late fees configuration
      #
      # API to update template late fees configuration by template id
      def update_invoice_payment_methods_configuration(template_id:, body:, **_opts)
        request(
          method: :patch,
          path: "/invoices/template/#{template_id}/payment-methods-configuration",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # List schedules
      #
      # API to get list of schedules
      def list_invoice_schedules(alt_id: nil, alt_type: nil, status: nil, start_at: nil, end_at: nil, search: nil, payment_mode: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/schedule",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "status" => status, "startAt" => start_at, "endAt" => end_at, "search" => search, "paymentMode" => payment_mode, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Create Invoice Schedule
      #
      # API to create an invoice Schedule
      def create_invoice_schedule(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/schedule",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Get an schedule
      #
      # API to get an schedule by schedule id
      def get_invoice_schedule(schedule_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/schedule/#{schedule_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update schedule
      #
      # API to update an schedule by schedule id
      def update_invoice_schedule(schedule_id:, body:, **_opts)
        request(
          method: :put,
          path: "/invoices/schedule/#{schedule_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete schedule
      #
      # API to delete an schedule by schedule id
      def delete_invoice_schedule(schedule_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :delete,
          path: "/invoices/schedule/#{schedule_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update scheduled recurring invoice
      #
      # API to update scheduled recurring invoice
      def update_and_schedule_invoice_schedule(schedule_id:, **_opts)
        request(
          method: :post,
          path: "/invoices/schedule/#{schedule_id}/updateAndSchedule",
          security: %w[Location-Access Agency-Access]
        )
      end

      # Schedule an schedule invoice
      #
      # API to schedule an schedule invoice to start sending to the customer
      def schedule_invoice_schedule(schedule_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/schedule/#{schedule_id}/schedule",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Manage Auto payment for an schedule invoice
      #
      # API to manage auto payment for a schedule
      def auto_payment_invoice_schedule(schedule_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/schedule/#{schedule_id}/auto-payment",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Cancel an scheduled invoice
      #
      # API to cancel a scheduled invoice by schedule id
      def cancel_invoice_schedule(schedule_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/schedule/#{schedule_id}/cancel",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Create & Send
      #
      # API to create or update a text2pay invoice
      def text2pay_invoice(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/text2pay",
          security: ["Location-Access"],
          body: body
        )
      end

      # Generate Invoice Number
      #
      # Get the next invoice number for the given location
      def generate_invoice_number(alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/generate-invoice-number",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Get Invoice Settings
      #
      # Get the invoice settings for the given location
      def get_invoice_settings(alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/settings",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Get invoice
      #
      # API to get invoice by invoice id
      def get_invoice(invoice_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/#{invoice_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update invoice
      #
      # API to update invoice by invoice id
      def update_invoice(invoice_id:, body:, **_opts)
        request(
          method: :put,
          path: "/invoices/#{invoice_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete invoice
      #
      # API to delete invoice by invoice id
      def delete_invoice(invoice_id:, alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :delete,
          path: "/invoices/#{invoice_id}",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Update invoice late fees configuration
      #
      # API to update invoice late fees configuration by invoice id
      def update_invoice_late_fees_configuration(invoice_id:, body:, **_opts)
        request(
          method: :patch,
          path: "/invoices/#{invoice_id}/late-fees-configuration",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Void invoice
      #
      # API to delete invoice by invoice id
      def void_invoice(invoice_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/#{invoice_id}/void",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Send invoice
      #
      # API to send invoice by invoice id
      def send_invoice(invoice_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/#{invoice_id}/send",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Record a manual payment for an invoice
      #
      # API to record manual payment for an invoice by invoice id
      def record_invoice(invoice_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/#{invoice_id}/record-payment",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Update invoice last visited at
      #
      # API to update invoice last visited at by invoice id
      def update_invoice_last_visited_at(body:, **_opts)
        request(
          method: :patch,
          path: "/invoices/stats/last-visited-at",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Create New Estimate
      #
      # Create a new estimate with the provided details
      def create_new_estimate(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/estimate",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Update Estimate
      #
      # Update an existing estimate with new details
      def update_estimate(estimate_id:, body:, **_opts)
        request(
          method: :put,
          path: "/invoices/estimate/#{estimate_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete Estimate
      #
      # Delete an existing estimate
      def delete_estimate(estimate_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/invoices/estimate/#{estimate_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Generate Estimate Number
      #
      # Get the next estimate number for the given location
      def generate_estimate_number(alt_id: nil, alt_type: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/estimate/number/generate",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type }.compact
        )
      end

      # Send Estimate
      #
      # API to send estimate by estimate id
      def send_estimate(estimate_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/estimate/#{estimate_id}/send",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Create Invoice from Estimate
      #
      # Create a new invoice from an existing estimate
      def create_invoice_from_estimate(estimate_id:, body:, **_opts)
        request(
          method: :post,
          path: "/invoices/estimate/#{estimate_id}/invoice",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # List Estimates
      #
      # Get a paginated list of estimates
      def list_estimates(alt_id: nil, alt_type: nil, start_at: nil, end_at: nil, search: nil, status: nil, contact_id: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/estimate/list",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "startAt" => start_at, "endAt" => end_at, "search" => search, "status" => status, "contactId" => contact_id, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Update estimate last visited at
      #
      # API to update estimate last visited at by estimate id
      def update_estimate_last_visited_at(body:, **_opts)
        request(
          method: :patch,
          path: "/invoices/estimate/stats/last-visited-at",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # List Estimate Templates
      #
      # Get a list of estimate templates or a specific template by ID
      def list_estimate_templates(alt_id: nil, alt_type: nil, search: nil, limit: nil, offset: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/estimate/template",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "search" => search, "limit" => limit, "offset" => offset }.compact
        )
      end

      # Create Estimate Template
      #
      # Create a new estimate template
      def create_estimate_template(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/estimate/template",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Update Estimate Template
      #
      # Update an existing estimate template
      def update_estimate_template(template_id:, body:, **_opts)
        request(
          method: :put,
          path: "/invoices/estimate/template/#{template_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Delete Estimate Template
      #
      # Delete an existing estimate template
      def delete_estimate_template(template_id:, body:, **_opts)
        request(
          method: :delete,
          path: "/invoices/estimate/template/#{template_id}",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end

      # Preview Estimate Template
      #
      # Get a preview of an estimate template
      def preview_estimate_template(alt_id: nil, alt_type: nil, template_id: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/estimate/template/preview",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "templateId" => template_id }.compact
        )
      end

      # List invoices
      #
      # API to get list of invoices
      def list_invoices(alt_id: nil, alt_type: nil, status: nil, start_at: nil, end_at: nil, search: nil, payment_mode: nil, contact_id: nil, limit: nil, offset: nil, sort_field: nil, sort_order: nil, **_opts)
        request(
          method: :get,
          path: "/invoices/",
          security: %w[Location-Access Agency-Access],
          params: { "altId" => alt_id, "altType" => alt_type, "status" => status, "startAt" => start_at, "endAt" => end_at, "search" => search, "paymentMode" => payment_mode, "contactId" => contact_id, "limit" => limit, "offset" => offset, "sortField" => sort_field, "sortOrder" => sort_order }.compact
        )
      end

      # Create Invoice
      #
      # API to create an invoice
      def create_invoice(body:, **_opts)
        request(
          method: :post,
          path: "/invoices/",
          security: %w[Location-Access Agency-Access],
          body: body
        )
      end
    end
  end
end
