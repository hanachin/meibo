# frozen_string_literal: true

module Meibo
  class Role
    Data.define(
      self,
      filename: 'roles.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        user_sourced_id: 'userSourcedId',
        role_type: 'roleType',
        role: 'role',
        begin_date: 'beginDate',
        end_date: 'endDate',
        org_sourced_id: 'orgSourcedId',
        user_profile_sourced_id: 'userProfileSourcedId'
      },
      converters: {
        date: [:begin_date, :end_date]
      }
    )

    TYPES = {
      primary: 'primary',
      secondary: 'secondary'
    }.freeze

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

    def initialize(sourced_id:, user_sourced_id:, role_type:, role:, begin_date: nil, end_date: nil, org_sourced_id:, user_profile_sourced_id: nil)
      @sourced_id = sourced_id
      @user_sourced_id = user_sourced_id
      @role_type = role_type
      @role = role
      @begin_date = begin_date
      @end_date = end_date
      @org_sourced_id = org_sourced_id
      @user_profile_sourced_id = user_profile_sourced_id
    end
  end
end
