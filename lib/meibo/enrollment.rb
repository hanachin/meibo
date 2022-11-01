# frozen_string_literal: true

module Meibo
  class Enrollment
    DataModel.define(
      self,
      filename: 'enrollments.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        class_sourced_id: 'classSourcedId',
        school_sourced_id: 'schoolSourcedId',
        user_sourced_id: 'userSourcedId',
        role: 'role',
        primary: 'primary',
        begin_date: 'beginDate',
        end_date: 'endDate',
        shusseki_no: 'metadata.jp.ShussekiNo',
        public_flg: 'metadata.jp.PublicFlg'
      },
      converters: {
        boolean: [:public_flg],
        date: [:begin_date, :end_date],
        integer: [:shusseki_no]
      },
      validation: {
        required: [:sourced_id, :class_sourced_id, :school_sourced_id, :user_sourced_id, :role]
      }
    )

    ROLES = {
      student: 'student',
      teacher: 'teacher',
      administrator: 'administrator',
      guardian: 'guardian'
    }.freeze

    # NOTE: 児童生徒の場合primaryはfalse固定
    # MEMO: 保護者の場合もそうでは?
    def initialize(sourced_id:, status: nil, date_last_modified: nil, class_sourced_id:, school_sourced_id:, user_sourced_id:, role:, primary: (role == ROLES[:student] ? false : nil), begin_date: nil, end_date: nil, shusseki_no: nil, public_flg: nil)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @class_sourced_id = class_sourced_id
      @school_sourced_id = school_sourced_id
      @user_sourced_id = user_sourced_id
      @role = role
      @begin_date = begin_date
      @end_date = end_date
      @shusseki_no = shusseki_no
      @public_flg = public_flg
    end
  end
end
