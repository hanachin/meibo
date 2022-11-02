# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module OrganizationBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :parent]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, parent: nil, **kw)
        super(sourced_id: sourced_id, parent_sourced_id: parent&.sourced_id, **kw)
        @builder = builder
        @parent = parent
        builder.organizations << self
      end

      def build_course(**kw)
        builder.build_course(organization: self, **kw)
      end

      def build_user(**kw)
        builder.build_user(primary_organization: self, **kw)
      end

      def build_role(**kw)
        builder.build_role(organization: self, **kw)
      end
    end
  end
end
