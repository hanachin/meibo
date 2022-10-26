# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class CourseBuilder < Course
      attr_reader :builder, :school_year, :organization

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
        ClassroomBuilder.new(builder: builder, course: self, school: organization, **kw)
      end
    end
  end
end
