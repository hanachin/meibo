# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Demographic < ::Meibo::Demographic
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          enum: { sex: SEX.values.freeze }
        ).freeze
      )
    end
  end
end
