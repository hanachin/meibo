# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      class Course < ::Meibo::JapanProfile::V1_1::Course
        define_converters(superclass.converters.merge(fullwidth: [*superclass.converters[:fullwidth], :title]))
      end
    end
  end
end
