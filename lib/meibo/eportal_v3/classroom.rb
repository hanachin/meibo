# frozen_string_literal: true

module Meibo
  module EportalV3
    class Classroom < ::Meibo::JapanProfile::Classroom
      converters = superclass.converters.merge(
        fullwidth: %i[title location]
      )
      define_converters(converters)
    end
  end
end
