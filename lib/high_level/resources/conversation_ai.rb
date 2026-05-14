# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/conversation-ai.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class ConversationAi < Base
      # Attach Action to Agent
      #
      # Creates and attach a new action for an AI agent. Actions define specific tasks or behaviors that the agent can perform, such as booking appointments, sending follow-ups, or collecting information.
      def create_action(agent_id:, body:, **_opts)
        request(
          method: :post,
          path: "/conversation-ai/agents/#{agent_id}/actions",
          security: ["bearer"],
          body: body
        )
      end

      # List Actions for an Agent
      #
      # List for actions for an agent
      def list_actions(agent_id:, **_opts)
        request(
          method: :get,
          path: "/conversation-ai/agents/#{agent_id}/actions/list",
          security: ["bearer"]
        )
      end

      # Get Action by ID
      #
      # Retrieves detailed information about a specific action using its unique identifier. Returns the action configuration, associated agents, and performance metrics.
      def get_action_by_id(action_id:, agent_id:, **_opts)
        request(
          method: :get,
          path: "/conversation-ai/agents/#{agent_id}/actions/#{action_id}",
          security: ["bearer"]
        )
      end

      # Update Action
      #
      # Updates an existing action's configuration. This includes modifying the action name, description, trigger conditions, and behavior settings.
      def update_action(action_id:, agent_id:, body:, **_opts)
        request(
          method: :put,
          path: "/conversation-ai/agents/#{agent_id}/actions/#{action_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Remove Action from Agent
      #
      # Permanently deletes an action. This will remove the action from all associated agents and cannot be undone.
      def delete_action(action_id:, agent_id:, **_opts)
        request(
          method: :delete,
          path: "/conversation-ai/agents/#{agent_id}/actions/#{action_id}",
          security: ["bearer"]
        )
      end

      # Update Followup Settings
      #
      # Update the followup settings for an action
      def update_followup_settings(agent_id:, body:, **_opts)
        request(
          method: :patch,
          path: "/conversation-ai/agents/#{agent_id}/followup-settings",
          security: ["bearer"],
          body: body
        )
      end

      # Create an Agent
      #
      # Creates a new AI agent for the location. The agent will be created with the specified configuration including name, role, actions, and behavior settings.
      def create_agent(body:, **_opts)
        request(
          method: :post,
          path: "/conversation-ai/agents",
          security: ["bearer"],
          body: body
        )
      end

      # Search Agents
      #
      # Searches for AI agents based on various criteria including name, status, and configuration. Supports advanced filtering and full-text search capabilities.
      def search_agent(start_after: nil, limit: nil, query: nil, **_opts)
        request(
          method: :get,
          path: "/conversation-ai/agents/search",
          security: ["bearer"],
          params: { "startAfter" => start_after, "limit" => limit, "query" => query }.compact
        )
      end

      # Get Agent
      #
      # Retrieves a specific AI agent by its ID. Returns the complete agent configuration including name, status, actions, and settings.
      def get_agent(agent_id:, **_opts)
        request(
          method: :get,
          path: "/conversation-ai/agents/#{agent_id}",
          security: ["bearer"]
        )
      end

      # Update Agent
      #
      # Updates an existing AI agent's configuration. All fields in the agent configuration can be updated including name, status, actions, and behavior settings.
      def update_agent(agent_id:, body:, **_opts)
        request(
          method: :put,
          path: "/conversation-ai/agents/#{agent_id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Agent
      #
      # Deletes an AI agent permanently. This action cannot be undone. All associated configurations and conversation history will be removed.
      def delete_agent(agent_id:, **_opts)
        request(
          method: :delete,
          path: "/conversation-ai/agents/#{agent_id}",
          security: ["bearer"]
        )
      end

      # Get the generation details
      #
      # Retrieves detailed information about AI responses including the System Prompt, Conversation history, Knowledge base, website, FAQ chunks, and Rich Text chunks.
      def get_generation_details(message_id: nil, source: nil, **_opts)
        request(
          method: :get,
          path: "/conversation-ai/generations",
          security: ["bearer"],
          params: { "messageId" => message_id, "source" => source }.compact
        )
      end
    end
  end
end
