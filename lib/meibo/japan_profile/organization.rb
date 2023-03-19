# frozen_string_literal: true

module Meibo
  module JapanProfile
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
