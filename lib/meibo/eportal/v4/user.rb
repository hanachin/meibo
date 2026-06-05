# frozen_string_literal: true

module Meibo
  module Eportal
    module V4
      class User < JapanProfile::User
        define_converters(
          fullwidth: %i[
            given_name
            family_name
            middle_name
            preferred_given_name
            preferred_middle_name
            preferred_family_name
            kana_given_name
            kana_family_name
            kana_middle_name
            kana_preferred_family_name
            kana_preferred_given_name
            kana_preferred_middle_name
          ],
          required: [*superclass.converters[:required], :user_master_identifier, :preferred_given_name, :preferred_family_name, :kana_given_name, :kana_family_name]
        )
      end
    end
  end
end
