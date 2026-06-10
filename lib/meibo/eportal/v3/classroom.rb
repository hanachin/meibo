# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      class Classroom < ::Meibo::JapanProfile::V1_1::Classroom
        define_converters(superclass.converters.merge(fullwidth: [*superclass.converters[:fullwidth], :title, :location]))
      end
    end
  end
end
