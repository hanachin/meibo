# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Role < ::Meibo::Role
      # NOTE: roleは固定
      #   - 児童生徒の場合student
      #   - 教職員の場合teacher
      #   - 保護者の場合guardian
      # MEMO: enrollments.csvの方ではadministratorとguardianも許可されているがズレてないか
      ROLES = {
        teacher: 'teacher',
        student: 'student',
        guardian: 'guardian'
      }.freeze

      DataModel.define(
        self,
        filename: 'roles.csv',
        attribute_name_to_header_field_map: superclass.attribute_name_to_header_field_map,
        converters: superclass.converters.merge(
          enum: superclass.converters[:enum].merge(role: ROLES.values).freeze
        )
      )
    end
  end
end
