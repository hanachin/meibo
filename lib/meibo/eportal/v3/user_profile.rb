# frozen_string_literal: true

module Meibo
  module Eportal::V3
    class UserProfile < ::Meibo::JapanProfile::UserProfile
      converters = superclass.converters.merge(
        fullwidth: %i[description]
      )
      define_converters(converters)
    end
  end
end
