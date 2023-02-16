# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Classroom < ::Meibo::Classroom
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map.merge(
          special_needs: "metadata.jp.specialNeeds"
        ).freeze,
        converters: superclass.converters.merge(
          boolean: [:special_needs].freeze,
          enum: { class_type: TYPES.values.freeze }.freeze
        ).freeze
      )

      def initialize(special_needs: nil, **other_fields)
        super(**other_fields)
        @special_needs = special_needs
      end
    end
  end
end
