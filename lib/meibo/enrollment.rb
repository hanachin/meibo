# frozen_string_literal: true

module Meibo
  class Enrollment
    ROLES = {
      administrator: 'administrator',
      proctor: 'proctor',
      student: 'student',
      teacher: 'teacher'
    }.freeze

    DataModel.define(
      self,
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
        end_date: 'endDate'
      }.freeze,
      converters: {
        boolean: [:primary].freeze,
        date: [:begin_date, :end_date].freeze,
        datetime: [:date_last_modified].freeze,
        enum: { role: [*ROLES.values, ENUM_EXT_PATTERN].freeze }.freeze,
        required: [:sourced_id, :class_sourced_id, :school_sourced_id, :user_sourced_id, :role].freeze,
        status: [:status].freeze
      }
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, class_sourced_id:, school_sourced_id:, user_sourced_id:, role:, primary: nil, begin_date: nil, end_date: nil, shusseki_no: nil, public_flg: nil, **extension_fields)
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
      @extension_fields = extension_fields
    end
  end
end
