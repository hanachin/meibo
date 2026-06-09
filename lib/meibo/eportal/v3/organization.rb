# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      class Organization < ::Meibo::JapanProfile::V1_1::Organization
        define_converters(superclass.converters.merge(fullwidth: [*superclass.converters[:fullwidth], :name]))
      end
    end
  end
end
