# frozen_string_literal: true

module Meibo
  module Eportal::V3
    class Course < ::Meibo::JapanProfile::V1_2_Ed2::Course
      converters = superclass.converters.merge(
        fullwidth: %i[title]
      )
      define_converters(converters)
    end
  end
end
