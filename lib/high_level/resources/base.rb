# frozen_string_literal: true

module HighLevel
  # Namespace for the generated API resource classes. Each
  # +vendor/openapi/apps/<app>.json+ spec emits one
  # +HighLevel::Resources::<App>+ class; +RESOURCE_REGISTRY+ maps them to
  # +client.<app>+ accessors.
  module Resources
    # Base class every generated resource inherits from. Owns the single
    # {#request} entry point that generated methods delegate to. All
    # logic — auth resolution, error mapping, refresh-on-401 — lives in
    # the middleware stack on +client.connection+; this class is glue.
    class Base
      # @param client [HighLevel::Client] the owning client
      def initialize(client)
        @client = client
      end

      protected

      # Dispatches a single API request through +client.connection+,
      # attaching the operation's security requirements to the request
      # context so {Middleware::Authentication} can resolve the token.
      #
      # @param method [Symbol] the HTTP verb
      # @param path [String] the request path
      # @param security [Array<String>] the operation's security requirements
      # @param params [Hash, nil] query parameters
      # @param body [Object, nil] the request body
      # @param headers [Hash, nil] extra request headers
      # @return [Object] the parsed response body
      def request(method:, path:, security:, params: nil, body: nil, headers: nil)
        response = @client.connection.run_request(method, path, body, nil) do |req|
          req.params.update(params) if params && !params.empty?
          headers&.each { |k, v| req.headers[k] = v }
          req.options.context = {
            HighLevel::Middleware::Authentication::CONTEXT_KEY => {
              security_requirements: Array(security)
            }
          }
        end
        response.body
      end
    end
  end
end
