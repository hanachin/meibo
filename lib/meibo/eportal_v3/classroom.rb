# frozen_string_literal: true

module Meibo
  module EportalV3
    class Classroom < ::Meibo::JapanProfile::Classroom
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          fullwidth: %i[title location].freeze
        ).freeze
      )
    end
  end
end
