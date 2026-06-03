# frozen_string_literal: true

module Meibo
  module EportalV3
    class UserProfile < ::Meibo::JapanProfile::V1_2_Ed2::UserProfile
      converters = superclass.converters.merge(
        fullwidth: %i[description]
      )
      define_converters(converters)
    end
  end
end
