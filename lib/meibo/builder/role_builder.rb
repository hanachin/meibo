# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module RoleBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :user, :organization, :user_profile]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, user:, organization:, user_profile: nil, **kw)
        super(
          sourced_id: sourced_id,
          user_sourced_id: user.sourced_id,
          org_sourced_id: organization.sourced_id,
          user_profile_sourced_id: user_profile&.sourced_id,
          **kw
        )
        @builder = builder
        @user = user
        @organization = organization
        @user_profile = user_profile
        builder.roles << self
      end
    end
  end
end
