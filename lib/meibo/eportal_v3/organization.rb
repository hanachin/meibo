# frozen_string_literal: true

module Meibo
  module EportalV3
    class Organization < ::Meibo::JapanProfile::Organization
      converters = superclass.converters.merge(
        fullwidth: %i[name]
      )
      define_converters(converters)
    end
  end
end
