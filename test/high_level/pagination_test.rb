# frozen_string_literal: true

require "test_helper"

module HighLevel
  class PaginationTest < Minitest::Test
    # Records every call so we can assert the cursor advanced correctly.
    class FakePages
      attr_reader :calls

      def initialize(pages, cursor_field:)
        @pages = pages
        @cursor_field = cursor_field
        @calls = []
      end

      def call(**args)
        @calls << args
        cursor = args.fetch(@cursor_field)
        @pages[cursor] || { "items" => [] }
      end
    end

    def test_each_page_walks_offset_until_a_short_page
      fake = FakePages.new(
        {
          0 => { "items" => [1, 2] },
          2 => { "items" => [3, 2] },
          4 => { "items" => [5] }
        },
        cursor_field: :offset
      )

      pages = []
      Pagination.each_page(fake, cursor_field: :offset, items_field: "items", page_size: 2) do |page|
        pages << page
      end

      assert_equal 3, pages.length
      assert_equal([0, 2, 4], fake.calls.map { |c| c[:offset] })
      assert_equal([2, 2, 2], fake.calls.map { |c| c[:limit] })
    end

    def test_each_page_supports_the_skip_convention
      fake = FakePages.new(
        { 0 => { "items" => %w[a b] }, 2 => { "items" => %w[c] } },
        cursor_field: :skip
      )

      pages = []
      Pagination.each_page(fake, cursor_field: :skip, items_field: "items", page_size: 2) { |p| pages << p }

      assert_equal 2, pages.length
      assert_equal([0, 2], fake.calls.map { |c| c[:skip] })
    end

    def test_each_page_stops_immediately_on_an_empty_first_page
      fake = FakePages.new({ 0 => { "items" => [] } }, cursor_field: :offset)

      pages = []
      Pagination.each_page(fake, cursor_field: :offset, items_field: "items", page_size: 10) { |p| pages << p }

      assert_empty pages
      assert_equal 1, fake.calls.length
    end

    def test_each_page_forwards_extra_args_on_every_call
      fake = FakePages.new({ 0 => { "items" => [1] } }, cursor_field: :offset)

      seen = 0
      Pagination.each_page(
        fake, cursor_field: :offset, items_field: "items", page_size: 5, location_id: "loc-1"
      ) { |_page| seen += 1 }

      assert_equal 1, seen
      assert_equal "loc-1", fake.calls.first[:location_id]
    end

    def test_each_page_without_a_block_returns_an_enumerator
      fake = FakePages.new(
        { 0 => { "items" => [1, 2] }, 2 => { "items" => [3] } },
        cursor_field: :offset
      )

      enum = Pagination.each_page(fake, cursor_field: :offset, items_field: "items", page_size: 2)
      assert_kind_of Enumerator, enum
      assert_equal 2, enum.to_a.length
    end

    def test_each_item_flattens_across_pages
      fake = FakePages.new(
        {
          0 => { "items" => %w[a b] },
          2 => { "items" => %w[c d] },
          4 => { "items" => %w[e] }
        },
        cursor_field: :offset
      )

      collected = []
      Pagination.each_item(fake, cursor_field: :offset, items_field: "items", page_size: 2) do |item|
        collected << item
      end

      assert_equal %w[a b c d e], collected
    end

    def test_iterates_a_real_endpoint_under_webmock
      base = "https://services.leadconnectorhq.com"
      stub_request(:get, "#{base}/contacts/abc/tasks")
        .with(query: { "limit" => "2", "offset" => "0" })
        .to_return(status: 200, body: '{"tasks":[{"id":1},{"id":2}]}',
                   headers: { "Content-Type" => "application/json" })
      stub_request(:get, "#{base}/contacts/abc/tasks")
        .with(query: { "limit" => "2", "offset" => "2" })
        .to_return(status: 200, body: '{"tasks":[{"id":3}]}',
                   headers: { "Content-Type" => "application/json" })

      client = Client.new(private_integration_token: "pit-xyz")
      fetch = ->(**page) { client.connection.get("/contacts/abc/tasks", page).body }

      ids = []
      Pagination.each_item(fetch, cursor_field: :offset, items_field: "tasks", page_size: 2) do |task|
        ids << task["id"]
      end

      assert_equal [1, 2, 3], ids
    end
  end
end
