# frozen_string_literal: true

module Meibo
  module JapanProfile::V1_2_Ed2
    class Organization < ::Meibo::Organization
      TYPES = {
        district: "district",
        school: "school"
      }.freeze

      converters = superclass.converters.merge(
        enum: { type: TYPES.values }
      )
      define_converters(converters)
    end
  end
end
