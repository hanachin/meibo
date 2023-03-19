# frozen_string_literal: true

module Meibo
  module EportalV3
    class User < ::Meibo::JapanProfile::UserM0
      converters = superclass.converters.merge(
        fullwidth: %i[given_name family_name middle_name preferred_given_name preferred_middle_name preferred_family_name kana_given_name kana_family_name kana_middle_name],
        required: [*superclass.converters[:required], :user_master_identifier, :preferred_given_name, :preferred_family_name, :kana_given_name, :kana_family_name]
      )
      define_converters(converters)
    end
  end
end
