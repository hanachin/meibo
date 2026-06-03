# frozen_string_literal: true

module Meibo
  module JapanProfile
    class UserM0 < ::Meibo::UserM0
      define_attributes(
        superclass.attribute_names_to_header_fields.merge(
          kana_given_name: "metadata.jp.kanaGivenName",
          kana_family_name: "metadata.jp.kanaFamilyName",
          kana_middle_name: "metadata.jp.kanaMiddleName",
          home_class: "metadata.jp.homeClass"
        )
      )

      define_converters(
        superclass.converters.merge(
          mext_grade_code: [:grades].freeze
        )
      )

      # NOTE: enabled_userは必須ではないが固定
      def initialize(
        enabled_user: true,
        kana_given_name: nil, kana_family_name: nil, kana_middle_name: nil, home_class: nil,
        **
      )
        super(enabled_user:, **)
        @kana_given_name = kana_given_name
        @kana_family_name = kana_family_name
        @kana_middle_name = kana_middle_name
        @home_class = home_class
      end

      def home_classroom
        home_class && Meibo.current_roster.classes.find(home_class)
      end
    end
  end
end
