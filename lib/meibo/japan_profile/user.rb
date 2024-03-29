# frozen_string_literal: true

module Meibo
  module JapanProfile
    class User < ::Meibo::User
      module ClassMethods
        def define_additional_definition
          attribute_names_to_header_fields = superclass.attribute_names_to_header_fields.merge(
            kana_given_name: "metadata.jp.kanaGivenName",
            kana_family_name: "metadata.jp.kanaFamilyName",
            kana_middle_name: "metadata.jp.kanaMiddleName",
            home_class: "metadata.jp.homeClass"
          )
          define_attributes(attribute_names_to_header_fields)

          converters = superclass.converters.merge(
            mext_grade_code: [:grades].freeze
          )
          define_converters(converters)
        end
      end

      module InstanceMethods
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

      include InstanceMethods
      extend ClassMethods

      define_additional_definition
    end
  end
end
