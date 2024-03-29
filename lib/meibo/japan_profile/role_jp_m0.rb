# frozen_string_literal: true

module Meibo
  module JapanProfile
    class RoleJpM0 < ::Meibo::Role
      # NOTE: roleは固定
      #   - 児童生徒の場合student
      #   - 教職員の場合teacher
      #   - 保護者の場合guardian
      # MEMO: enrollments.csvの方ではadministratorとguardianも許可されているがズレてないか
      ROLES = {
        teacher: "teacher",
        student: "student",
        guardian: "guardian"
      }.freeze

      converters = superclass.converters.merge(
        enum: superclass.converters[:enum].merge(role: ROLES.values)
      )
      define_converters(converters)
    end
  end
end
