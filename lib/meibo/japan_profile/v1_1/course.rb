# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class Course < ::Meibo::OneRoster::V1_2::Course
        define_converters(superclass.converters.merge(enum: { course_code: [""] }, mext_grade_code: [:grades]))

        # NOTE: courseCodeは空文字固定
        def initialize(course_code: "", **)
          super
        end
      end
    end
  end
end
