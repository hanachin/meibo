# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class UserBuilder < User
      attr_reader :builder, :agents, :primary_organization

      def initialize(builder:, sourced_id: SecureRandom.uuid, agents: nil, primary_organization: nil, **kw)
        super(
          sourced_id: sourced_id,
          agent_sourced_ids: agents&.map(&:sourced_id),
          primary_org_sourced_id: primary_organization&.sourced_id,
          **kw
        )
        @builder = builder
        @agents = agents
        @primary_organization = primary_organization
        builder.users << self
      end

      def build_demographic(**kw)
        DemographicBuilder.new(builder: builder, user: self, **kw)
      end

      def build_profile(**kw)
        UserProfileBuilder.new(builder: builder, user: self, **kw)
      end
    end
  end
end
