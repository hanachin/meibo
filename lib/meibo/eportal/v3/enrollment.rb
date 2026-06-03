# frozen_string_literal: true

module Meibo
  module Eportal::V3
    class Enrollment < ::Meibo::JapanProfile::V1_2_Ed2::Enrollment
      converters = superclass.converters.merge(
        required: [*superclass.converters[:required], :primary]
      )
      define_converters(converters)
    end
  end
end
