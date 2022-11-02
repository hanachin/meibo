# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module CourseBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :school_year, :organization]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, school_year: nil, organization:, **kw)
        super(
          sourced_id: sourced_id,
          school_year_sourced_id: school_year&.sourced_id,
          org_sourced_id: organization.sourced_id,
          **kw
        )
        @builder = builder
        @school_year = school_year
        @organization = organization
        builder.courses << self
      end

      def build_classroom(**kw)
        builder.build_classroom(course: self, school: organization, **kw)
      end
    end
  end
end
