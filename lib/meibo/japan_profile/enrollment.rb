# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Enrollment < ::Meibo::Enrollment
      ROLES = {
        student: "student",
        teacher: "teacher",
        administrator: "administrator",
        guardian: "guardian"
      }.freeze

      attribute_names_to_header_fields = superclass.attribute_names_to_header_fields.merge(
        shusseki_no: "metadata.jp.ShussekiNo",
        public_flg: "metadata.jp.PublicFlg"
      )
      define_attributes(attribute_names_to_header_fields)

      converters = superclass.converters.merge(
        boolean: [*superclass.converters[:boolean], :public_flg],
        enum: { role: ROLES.values },
        integer: [:shusseki_no]
      )
      define_converters(converters)

      # NOTE: 児童生徒の場合primaryはfalse固定
      # MEMO: 保護者の場合もそうでは?
      def initialize(role:, shusseki_no: nil, public_flg: nil, primary: (role == ROLES[:student] ? false : nil),
                     **other_fields)
        super(role: role, primary: primary, **other_fields)
        @shusseki_no = shusseki_no
        @public_flg = public_flg
      end

      def guardian?
        role == ROLES[:guardian]
      end
    end
  end
end
