# frozen_string_literal: true

module Meibo
  module EportalV3
    class Course < ::Meibo::JapanProfile::Course
      converters = superclass.converters.merge(
        fullwidth: %i[title]
      )
      define_converters(converters)
    end
  end
end
