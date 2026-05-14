# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/agent-studio.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class AgentStudio < Base
      # List Agents
      #
      # Lists all active agents for the specified location. locationId is required parameter to ensure optimal performance. Supports pagination using limit and offset. Optionally filter by isPublished=true to return only agents with a published production version.
      def get_agents(location_id: nil, is_published: nil, limit: nil, offset: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/agent-studio/agent",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "isPublished" => is_published, "limit" => limit, "offset" => offset, "source" => source }.compact
        )
      end

      # Create Agent
      #
      # Creates a new agent with staging version. The agent will be created with an initial staging version that can later be promoted to production.
      def create_agent(body:, source: nil, **_opts)
        request(
          method: :post,
          path: "/agent-studio/agent",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end

      # Update Agent
      #
      # Updates a specific agent version by versionId. Supports updating nodes, edges, variables, and configuration.
      def update_agent_version(version_id:, body:, source: nil, **_opts)
        request(
          method: :patch,
          path: "/agent-studio/agent/versions/#{version_id}",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end

      # Get Agent
      #
      # Gets a specific agent by its ID for the specified location with all its versions. Returns complete agent metadata and all non-deleted versions (draft, staging, production). locationId is required parameter. The agent must have active status.
      def get_agent_by_id(agent_id:, location_id: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/agent-studio/agent/#{agent_id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "source" => source }.compact
        )
      end

      # Update Agent Metadata
      #
      # Updates agent metadata such as name, description, and status.
      def update_agent_metadata(agent_id:, body:, source: nil, **_opts)
        request(
          method: :patch,
          path: "/agent-studio/agent/#{agent_id}",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end

      # Delete Agent
      #
      # Deletes an agent and all its versions.
      def delete_agent(agent_id:, location_id: nil, source: nil, **_opts)
        request(
          method: :delete,
          path: "/agent-studio/agent/#{agent_id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "source" => source }.compact
        )
      end

      # Promote to Production
      #
      # Promotes a draft version to production.
      def promote_and_publish(version_id:, body:, source: nil, **_opts)
        request(
          method: :post,
          path: "/agent-studio/agent/versions/#{version_id}/publish",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end

      # Execute Agent
      #
      # Executes the specified agent and returns a non-streaming JSON response with the complete agent output. The agent must be in active status and belong to the specified location. locationId is required in the request body.
      #
      # **Session Management:**
      # - For the first message in a new session, do not include the `executionId` in the request payload.
      # - The API will return an `executionId` along with the agent response, which uniquely identifies this conversation session.
      # - To continue the conversation within the same session, include the `executionId` from the previous response in subsequent requests. This allows the agent to maintain conversation context and history across multiple interactions.
      def execute_agent(agent_id:, body:, source: nil, **_opts)
        request(
          method: :post,
          path: "/agent-studio/agent/#{agent_id}/execute",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end

      # List Agents (Deprecated)
      #
      # **Deprecated endpoint - use GET /agent instead.**
      #
      # Lists all active agents that have a published production version for the specified location. locationId is required parameter. Supports pagination using limit and offset.
      def get_agents_deprecated(location_id: nil, limit: nil, offset: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/agent-studio/public-api/agents",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "limit" => limit, "offset" => offset, "source" => source }.compact
        )
      end

      # Get Agent (Deprecated)
      #
      # **Deprecated endpoint - use GET /agent/:agentId instead.**
      #
      # Gets a specific agent by its ID for the specified location with all its versions. locationId is required parameter. The agent must have active status.
      def get_agent_by_id_deprecated(agent_id:, location_id: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/agent-studio/public-api/agents/#{agent_id}",
          security: ["Location-Access"],
          params: { "locationId" => location_id, "source" => source }.compact
        )
      end

      # Execute Agent (Deprecated)
      #
      # **Deprecated endpoint - use POST /agent/:agentId/execute instead.**
      #
      # Executes the specified agent and returns a non-streaming JSON response with the complete agent output. The agent must be in active status and belong to the specified location. locationId is required in the request body.
      #
      # **Session Management:**
      # - For the first message in a new session, do not include the `executionId` in the request payload.
      # - The API will return an `executionId` along with the agent response, which uniquely identifies this conversation session.
      # - To continue the conversation within the same session, include the `executionId` from the previous response in subsequent requests.
      def execute_agent_deprecated(agent_id:, body:, source: nil, **_opts)
        request(
          method: :post,
          path: "/agent-studio/public-api/agents/#{agent_id}/execute",
          security: ["Location-Access"],
          params: { "source" => source }.compact,
          body: body
        )
      end
    end
  end
end
