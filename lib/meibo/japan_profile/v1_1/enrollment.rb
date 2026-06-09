# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class Enrollment < ::Meibo::OneRoster::V1_2::Enrollment
        ROLES = {
          student: "student",
          teacher: "teacher",
          administrator: "administrator",
          guardian: "guardian"
        }.freeze

        define_attributes(
          superclass.attribute_names_to_header_fields.merge(
            shusseki_no: "metadata.jp.ShussekiNo",
            public_flg: "metadata.jp.PublicFlg"
          )
        )

        define_converters(
          superclass.converters.merge(
            boolean: [*superclass.converters[:boolean], :public_flg],
            enum: { role: ROLES.values },
            integer: [:shusseki_no]
          )
        )

        # NOTE: 児童生徒の場合primaryはfalse固定
        # MEMO: 保護者の場合もそうでは?
        def initialize(
          role:,
          shusseki_no: nil,
          public_flg: nil,
          primary: (role == ROLES[:student] ? false : nil),
          **
        )
          super(role: role, primary: primary, **)
          @shusseki_no = shusseki_no
          @public_flg = public_flg
        end

        def guardian? = role == ROLES[:guardian]
      end
    end
  end
end
