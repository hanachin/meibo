# frozen_string_literal: true

module Meibo
  class JapanProfile < ::Meibo::Profile
    class User < ::Meibo::User
      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map.merge(
          kana_given_name: "metadata.jp.kanaGivenName",
          kana_family_name: "metadata.jp.kanaFamilyName",
          kana_middle_name: "metadata.jp.kanaMiddleName",
          home_class: "metadata.jp.homeClass"
        ).freeze,
        converters: superclass.converters
      )

      # NOTE: enabled_userは必須ではないが固定
      def initialize(enabled_user: true, kana_given_name: nil, kana_family_name: nil, kana_middle_name: nil,
                     home_class: nil, **other_fields)
        super(enabled_user: enabled_user, **other_fields)
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
