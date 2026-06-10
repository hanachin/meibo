# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class Classroom < ::Meibo::OneRoster::V1_2::Classroom
        define_attributes(
          superclass.attribute_names_to_header_fields.merge(
            special_needs: "metadata.jp.specialNeeds"
          )
        )
        define_converters(
          superclass.converters.merge(
            boolean: [:special_needs],
            enum: { class_type: TYPES.values },
            mext_grade_code: [:grades]
          )
        )

        def initialize(special_needs: nil, **)
          super(**)
          @special_needs = special_needs
        end
      end
    end
  end
end
