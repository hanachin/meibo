# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class UserProfileBuilder < UserProfile
      attr_reader :builder, :user

      def initialize(builder:, sourced_id: SecureRandom.uuid, user:, **kw)
        super(sourced_id: sourced_id, user_sourced_id: user.sourced_id, **kw)
        @builder = builder
        @user = user
        builder.user_profiles << self
      end
    end
  end
end
