# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Organization < ::Meibo::Organization
      TYPES = {
        district: "district",
        school: "school"
      }.freeze

      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          enum: { type: TYPES.values.freeze }
        ).freeze
      )
    end
  end
end
