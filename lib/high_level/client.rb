# frozen_string_literal: true

module HighLevel
  class Client
    attr_reader :config, :connection

    def initialize(config = nil, **opts)
      @config = coerce_config(config, opts)
      validate!
      @connection = build_connection
    end

    private

    def coerce_config(config, opts)
      case config
      when Configuration then config
      when Hash          then Configuration.new(**config, **opts)
      when nil           then Configuration.new(**opts)
      else
        raise ConfigurationError,
              "expected HighLevel::Configuration or Hash, got #{config.class}"
      end
    end

    def validate!
      return if any_token? || oauth_client_pair?

      raise ConfigurationError,
            "HighLevel::Client requires one of: private_integration_token, " \
            "agency_access_token, location_access_token, or client_id+client_secret"
    end

    def any_token?
      @config.private_integration_token ||
        @config.agency_access_token ||
        @config.location_access_token
    end

    def oauth_client_pair?
      @config.client_id && @config.client_secret
    end

    def build_connection
      Faraday.new(url: @config.base_url) do |f|
        f.request :json
        f.use Middleware::Authentication, config: @config
        f.use Middleware::ErrorHandler
        f.response :json, content_type: /\bjson\b/
        f.adapter Faraday.default_adapter
      end
    end
  end
end
