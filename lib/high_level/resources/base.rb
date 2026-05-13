# frozen_string_literal: true

module HighLevel
  module Resources
    # Base class every generated resource inherits from. Owns the single
    # `#request` entry point that generated methods delegate to. All
    # logic — auth resolution, error mapping, refresh-on-401 — lives in
    # the middleware stack on `client.connection`; this class is glue.
    class Base
      def initialize(client)
        @client = client
      end

      protected

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
