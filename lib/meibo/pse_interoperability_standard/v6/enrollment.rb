# frozen_string_literal: true

module Meibo
  module PSEInteroperabilityStandard
    module V6
      class Enrollment < JapanK12SchoolsProfile::Enrollment
        define_converters(superclass.converters.merge(required: [*superclass.converters[:required], :primary]))
      end
    end
  end
end
