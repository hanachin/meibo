# frozen_string_literal: true

module Meibo
  module Eportal::V3
    class Organization < ::Meibo::JapanProfile::V1_2_Ed2::Organization
      converters = superclass.converters.merge(
        fullwidth: %i[name]
      )
      define_converters(converters)
    end
  end
end
