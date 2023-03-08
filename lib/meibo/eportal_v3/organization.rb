# frozen_string_literal: true

module Meibo
  module EportalV3
    class Organization < ::Meibo::JapanProfile::Organization
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          fullwidth: %i[name].freeze
        ).freeze
      )
    end
  end
end
