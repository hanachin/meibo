# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      class UserProfile < ::Meibo::JapanProfile::V1_1::UserProfile
        define_converters(superclass.converters.merge(fullwidth: [*superclass.converters[:fullwidth], :description]))
      end
    end
  end
end
