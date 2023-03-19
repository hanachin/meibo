# frozen_string_literal: true

module Meibo
  module EportalV3
    class Enrollment < ::Meibo::JapanProfile::Enrollment
      converters = superclass.converters.merge(
        required: [*superclass.converters[:required], :primary]
      )
      define_converters(converters)
    end
  end
end
