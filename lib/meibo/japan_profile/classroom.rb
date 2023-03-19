# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Classroom < ::Meibo::Classroom
      attribute_names_to_header_fields = superclass.attribute_names_to_header_fields.merge(
        special_needs: "metadata.jp.specialNeeds"
      )
      define_attributes(attribute_names_to_header_fields)

      converters = superclass.converters.merge(
        boolean: [:special_needs],
        enum: { class_type: TYPES.values },
        mext_grade_code: [:grades]
      )
      define_converters(converters)

      def initialize(special_needs: nil, **other_fields)
        super(**other_fields)
        @special_needs = special_needs
      end
    end
  end
end
