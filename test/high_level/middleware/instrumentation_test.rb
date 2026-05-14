# frozen_string_literal: true

require "test_helper"

module HighLevel
  module Middleware
    class InstrumentationTest < Minitest::Test
      # Captures instrument(name, payload) { ... } calls the way
      # ActiveSupport::Notifications would receive them.
      class RecordingInstrumenter
        attr_reader :events

        def initialize
          @events = []
        end

        def instrument(name, payload)
          result = yield
          @events << { name: name, payload: payload.dup }
          result
        end
      end

      def make_env(status: 200)
        env = Faraday::Env.from(
          method: :get,
          url: URI.parse("https://services.leadconnectorhq.com/health")
        )
        env.status = status
        env
      end

      def test_passes_through_when_no_instrumenter
        app = ->(env) { env }
        middleware = Instrumentation.new(app, instrumenter: nil)

        assert_equal make_env, middleware.call(make_env)
      end

      def test_emits_an_event_with_method_url_and_status
        instrumenter = RecordingInstrumenter.new
        app = ->(env) { env.tap { |e| e.status = 201 } }
        middleware = Instrumentation.new(app, instrumenter: instrumenter)

        middleware.call(make_env)

        assert_equal 1, instrumenter.events.length
        event = instrumenter.events.first
        assert_equal "request.high_level", event[:name]
        assert_equal :get, event[:payload][:method]
        assert_equal "https://services.leadconnectorhq.com/health", event[:payload][:url]
        assert_equal 201, event[:payload][:status]
      end

      def test_client_wires_the_configured_instrumenter
        instrumenter = RecordingInstrumenter.new
        stub_request(:get, "https://services.leadconnectorhq.com/health")
          .to_return(status: 200, body: "{}", headers: { "Content-Type" => "application/json" })

        client = Client.new(private_integration_token: "pit", instrumenter: instrumenter)
        client.connection.get("/health")

        assert_equal 1, instrumenter.events.length
        assert_equal 200, instrumenter.events.first[:payload][:status]
      end
    end
  end
end
