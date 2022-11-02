# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module UserProfileBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :user]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, user:, **kw)
        super(sourced_id: sourced_id, user_sourced_id: user.sourced_id, **kw)
        @builder = builder
        @user = user
        builder.user_profiles << self
      end
    end
  end
end
