# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/voice-ai.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class VoiceAi < Base
      # List Agents
      #
      # Retrieve a paginated list of agents for given location.
      def get_agents(page: nil, page_size: nil, location_id: nil, query: nil, **_opts)
        request(
          method: :get,
          path: "/voice-ai/agents",
          security: ["bearer"],
          params: { "page" => page, "pageSize" => page_size, "locationId" => location_id, "query" => query }.compact
        )
      end

      # Create Agent
      #
      # Create a new voice AI agent configuration and settings
      def create_agent(body:, **_opts)
        request(
          method: :post,
          path: "/voice-ai/agents",
          security: ["bearer"],
          body: body
        )
      end

      # Get Agent
      #
      # Retrieve detailed configuration and settings for a specific voice AI agent
      def get_agent(agent_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/voice-ai/agents/#{agent_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Patch Agent
      #
      # Partially update an existing voice AI agent
      def patch_agent(agent_id:, body:, location_id: nil, **_opts)
        request(
          method: :patch,
          path: "/voice-ai/agents/#{agent_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact,
          body: body
        )
      end

      # Delete Agent
      #
      # Delete a voice AI agent and all its configurations
      def delete_agent(agent_id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/voice-ai/agents/#{agent_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # List Call Logs
      #
      # Returns call logs for Voice AI agents scoped to a location. Supports filtering by agent, contact, call type, action types, and date range (interpreted in the provided IANA timezone). Also supports sorting and 1-based pagination.
      def get_call_logs(location_id: nil, agent_id: nil, contact_id: nil, call_type: nil, start_date: nil, end_date: nil, action_type: nil, sort_by: nil, sort: nil, page: nil, page_size: nil, **_opts)
        request(
          method: :get,
          path: "/voice-ai/dashboard/call-logs",
          security: ["bearer"],
          params: { "locationId" => location_id, "agentId" => agent_id, "contactId" => contact_id, "callType" => call_type, "startDate" => start_date, "endDate" => end_date, "actionType" => action_type, "sortBy" => sort_by, "sort" => sort, "page" => page, "pageSize" => page_size }.compact
        )
      end

      # Get Call Log
      #
      # Returns a call log by callId.
      def get_call_log(call_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/voice-ai/dashboard/call-logs/#{call_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Agent Action
      #
      # Create a new action for a voice AI agent. Actions define specific behaviors and capabilities for the agent during calls.
      def create_action(body:, **_opts)
        request(
          method: :post,
          path: "/voice-ai/actions",
          security: ["bearer"],
          body: body
        )
      end

      # Get Agent Action
      #
      # Retrieve details of a specific action by its ID. Returns the action configuration including actionParameters.
      def get_action(action_id:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/voice-ai/actions/#{action_id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Update Agent Action
      #
      # Update an existing action for a voice AI agent. Modifies the behavior and configuration of an agent action.
      def update_action(action_id:, body:, **_opts)
        request(
          method: :put,
          path: "/voice-ai/actions/#{action_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Agent Action
      #
      # Delete an existing action from a voice AI agent. This permanently removes the action and its configuration.
      def delete_action(action_id:, location_id: nil, agent_id: nil, **_opts)
        request(
          method: :delete,
          path: "/voice-ai/actions/#{action_id}",
          security: ["bearer"],
          params: { "locationId" => location_id, "agentId" => agent_id }.compact
        )
      end
    end
  end
end
