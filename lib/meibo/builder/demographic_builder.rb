# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class DemographicBuilder < Demographic
      attr_reader :builder, :user

      def initialize(builder:, user:, **kw)
        super(sourced_id: user.sourced_id, **kw)
        @builder = builder
        @user = user
        builder.demographics << self
      end
    end
  end
end
