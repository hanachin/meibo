# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module DemographicBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :user]
      end

      def initialize(builder:, user:, **kw)
        super(sourced_id: user.sourced_id, **kw)
        @builder = builder
        @user = user
        builder.demographics << self
      end
    end
  end
end
