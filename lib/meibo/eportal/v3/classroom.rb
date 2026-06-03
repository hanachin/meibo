# frozen_string_literal: true

module Meibo
  module Eportal::V3
    class Classroom < ::Meibo::JapanProfile::V1_2_Ed2::Classroom
      converters = superclass.converters.merge(
        fullwidth: %i[title location]
      )
      define_converters(converters)
    end
  end
end
