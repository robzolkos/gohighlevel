# frozen_string_literal: true

module HighLevel
  # The entry point for the SDK. Construct one with credentials, then
  # reach each API app as a resource: +client.contacts+,
  # +client.calendars+, and so on (see +RESOURCE_REGISTRY+). OAuth flows
  # live on +client.oauth+.
  #
  # @!attribute [r] config
  #   @return [HighLevel::Configuration] the resolved, immutable configuration
  # @!attribute [r] connection
  #   @return [Faraday::Connection] the underlying HTTP connection with the
  #     full middleware stack
  # @!attribute [r] oauth
  #   @return [HighLevel::Oauth] the OAuth flow client
  class Client
    attr_reader :config, :connection, :oauth

    # @param config [HighLevel::Configuration, Hash, nil] a configuration
    #   object, a hash of configuration options, or nil to build one
    #   entirely from keyword arguments
    # @param opts [Hash] configuration options, merged over +config+
    # @raise [ConfigurationError] when no usable credentials are supplied
    def initialize(config = nil, **opts)
      @config = coerce_config(config, opts)
      validate!
      initialize_storage
      @oauth = Oauth.new(config: @config)
      @connection = build_connection
    end

    # @return [Boolean] whether +name+ is a registered resource accessor
    def respond_to_missing?(name, include_private = false)
      RESOURCE_REGISTRY.key?(name) || super
    end

    # Resolves +client.<app>+ to a memoized resource instance via
    # +RESOURCE_REGISTRY+.
    def method_missing(name, *args, **kwargs, &block)
      klass = RESOURCE_REGISTRY[name]
      return super unless klass && args.empty? && kwargs.empty? && block.nil?

      @resources ||= {}
      @resources[name] ||= klass.new(self)
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

    def initialize_storage
      storage = @config.session_storage
      return if storage.nil?

      storage.set_client_id(@config.client_id) if @config.client_id
      storage.init
    end

    def build_connection
      resolver = TokenResolver.new(config: @config, storage: @config.session_storage)
      refresher = TokenRefresher.new(config: @config, oauth: @oauth, storage: @config.session_storage)
      build_faraday(resolver, refresher)
    end

    def build_faraday(resolver, refresher)
      Faraday.new(url: @config.base_url) do |f|
        f.use Middleware::Instrumentation, instrumenter: @config.instrumenter
        f.use Middleware::RefreshOn401, refresher: refresher, resolver: resolver
        f.use Middleware::Authentication, config: @config, resolver: resolver
        f.request :json
        f.use Middleware::ErrorHandler
        f.response :json, content_type: /\bjson\b/
        f.adapter Faraday.default_adapter
      end
    end
  end
end
