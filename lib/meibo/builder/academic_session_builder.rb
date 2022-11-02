# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module AcademicSessionBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :parent]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, parent: nil, **kw)
        super(
          sourced_id: sourced_id,
          parent_sourced_id: parent&.sourced_id,
          **kw
        )
        @builder = builder
        @parent = parent
        builder.academic_sessions << self
      end
    end
  end
end
