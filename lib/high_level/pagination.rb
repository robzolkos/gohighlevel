# frozen_string_literal: true

module HighLevel
  # Opt-in pagination helper. HighLevel's API has no uniform pagination
  # convention — some endpoints use limit/offset, some limit/skip — so
  # nothing is auto-paginated inside the generated resource methods.
  # Callers reach for this explicitly.
  #
  # `resource_method` is anything responding to `#call`: a bound method
  # (`client.contacts.method(:some_listing)`) for endpoints whose
  # pagination params are plain kwargs, or a small proc that routes the
  # params into `body:` for endpoints that paginate via the request body.
  #
  # Example (limit/skip, params in the request body):
  #
  #   fetch = ->(**page) {
  #     client.contacts.search_contacts_advanced(
  #       body: { locationId: "loc-1" }.merge(page)
  #     )
  #   }
  #   HighLevel::Pagination.each_item(
  #     fetch, cursor_field: :skip, items_field: "contacts"
  #   ) { |contact| puts contact["id"] }
  module Pagination
    module_function

    # Yields each page (the raw response) until a short or empty page is
    # returned. Without a block, returns an Enumerator.
    # rubocop:disable Metrics/MethodLength
    def each_page(resource_method, cursor_field:, limit_field: :limit, page_size: 100, items_field: nil, **args)
      unless block_given?
        return enum_for(:each_page, resource_method,
                        cursor_field: cursor_field, limit_field: limit_field,
                        page_size: page_size, items_field: items_field, **args)
      end

      cursor = 0
      loop do
        page = resource_method.call(**args, limit_field => page_size, cursor_field => cursor)
        items = items_for(page, items_field)
        break if items.empty?

        yield page
        break if items.length < page_size

        cursor += page_size
      end
    end
    # rubocop:enable Metrics/MethodLength

    # Yields each individual item across all pages. Requires
    # `items_field` so it knows which key holds the collection. Without a
    # block, returns an Enumerator.
    def each_item(resource_method, items_field:, **opts, &block)
      return enum_for(:each_item, resource_method, items_field: items_field, **opts) unless block

      each_page(resource_method, items_field: items_field, **opts) do |page|
        items_for(page, items_field).each(&block)
      end
    end

    # Extract the page's collection. With no `items_field` the page is
    # assumed to already be an array-like.
    def items_for(page, items_field)
      return Array(page) if items_field.nil?
      return [] if page.nil?

      Array(page[items_field] || page[items_field.to_s])
    end
  end
end
