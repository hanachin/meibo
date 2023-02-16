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

      DataModel.define(
        self,
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map.merge(
          shusseki_no: "metadata.jp.ShussekiNo",
          public_flg: "metadata.jp.PublicFlg"
        ).freeze,
        converters: superclass.converters.merge(
          boolean: [*superclass.converters[:boolean], :public_flg].freeze,
          enum: { role: ROLES.values.freeze }.freeze,
          integer: [:shusseki_no].freeze
        ).freeze
      )

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
