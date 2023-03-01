# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Course < ::Meibo::Course
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(enum: { course_code: [""].freeze }.freeze, mext_grade_code: [:grades].freeze)
      )

      # NOTE: courseCodeは空文字固定
      def initialize(course_code: "", **other_fields)
        super(course_code: course_code, **other_fields)
      end
    end
  end
end
