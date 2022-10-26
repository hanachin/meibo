# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class OrganizationBuilder < Organization
      attr_reader :builder, :parent

      def initialize(builder:, sourced_id: SecureRandom.uuid, parent: nil, **kw)
        super(sourced_id: sourced_id, parent_sourced_id: parent&.sourced_id, **kw)
        @builder = builder
        @parent = parent
        builder.organizations << self
      end

      def build_course(**kw)
        CourseBuilder.new(builder: builder, organization: self, **kw)
      end

      def build_user(**kw)
        UserBuilder.new(builder: builder, primary_organization: self, **kw)
      end

      def build_role(**kw)
        RoleBuilder.new(builder: builder, organization: self, **kw)
      end
    end
  end
end
