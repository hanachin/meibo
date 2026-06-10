# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class Organization < ::Meibo::OneRoster::V1_2::Organization
        TYPES = {
          district: "district",
          school: "school"
        }.freeze

        define_converters(superclass.converters.merge(enum: { type: TYPES.values }))
      end
    end
  end
end
