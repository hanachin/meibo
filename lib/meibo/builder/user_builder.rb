# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module UserBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :agents, :primary_organization]
      end

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
        builder.build_demographic(user: self, **kw)
      end

      def build_profile(**kw)
        builder.build_user_profile(user: self, **kw)
      end
    end
  end
end
