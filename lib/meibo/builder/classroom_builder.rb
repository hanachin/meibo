# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    module ClassroomBuilder
      extend BaseBuilder

      def self.builder_attribute_names
        [:builder, :course, :school, :terms]
      end

      def initialize(builder:, sourced_id: SecureRandom.uuid, course:, school:, terms:, **kw)
        super(
          sourced_id: sourced_id,
          course_sourced_id: course.sourced_id,
          school_sourced_id: school.sourced_id,
          term_sourced_ids: terms.map(&:sourced_id),
          **kw
        )
        @builder = builder
        @course = course
        @school = school
        @terms = terms
        builder.classes << self
      end

      def build_enrollment(**kw)
        builder.build_enrollment(
          classroom: self,
          school: school,
          **kw
        )
      end
    end
  end
end
