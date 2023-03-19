# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Course < ::Meibo::Course
      converters = superclass.converters.merge(enum: { course_code: [""] }, mext_grade_code: [:grades])
      define_converters(converters)

      # NOTE: courseCodeは空文字固定
      def initialize(course_code: "", **other_fields)
        super(course_code: course_code, **other_fields)
      end
    end
  end
end
