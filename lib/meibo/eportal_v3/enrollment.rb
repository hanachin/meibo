# frozen_string_literal: true

module Meibo
  module EportalV3
    class Enrollment < ::Meibo::JapanProfile::Enrollment
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          required: [*superclass.converters[:required], :primary].freeze
        ).freeze
      )
    end
  end
end
