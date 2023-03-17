# frozen_string_literal: true

module Meibo
  module EportalV3
    class UserProfile < ::Meibo::JapanProfile::UserProfile
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          fullwidth: %i[description].freeze
        ).freeze
      )
    end
  end
end
