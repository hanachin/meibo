# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      class Enrollment < ::Meibo::JapanProfile::V1_1::Enrollment
        define_converters(superclass.converters.merge(required: [*superclass.converters[:required], :primary]))
      end
    end
  end
end
