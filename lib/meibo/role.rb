# frozen_string_literal: true

module Meibo
  class Role
    TYPES = {
      primary: 'primary',
      secondary: 'secondary'
    }.freeze

    ROLES = {
      aide: 'aide',
      counselor: 'counselor',
      district_administrator: 'districtAdministrator',
      guardian: 'guardian',
      parent: 'parent',
      principal: 'principal',
      proctor: 'proctor',
      relative: 'relative',
      site_administrator: 'siteAdministrator',
      student: 'student',
      system_administrator: 'systemAdministrator',
      teacher: 'teacher'
    }.freeze

    DataModel.define(
      self,
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        user_sourced_id: 'userSourcedId',
        role_type: 'roleType',
        role: 'role',
        begin_date: 'beginDate',
        end_date: 'endDate',
        org_sourced_id: 'orgSourcedId',
        user_profile_sourced_id: 'userProfileSourcedId'
      }.freeze,
      converters: {
        date: [:begin_date, :end_date].freeze,
        datetime: [:date_last_modified].freeze,
        required: [:sourced_id, :user_sourced_id, :role_type, :role, :org_sourced_id].freeze,
        enum: {
          role: [*ROLES.values, ENUM_EXT_PATTERN].freeze,
          role_type: TYPES.values.freeze
        }.freeze,
        status: [:status].freeze
      }.freeze
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, user_sourced_id:, role_type:, role:, begin_date: nil, end_date: nil, org_sourced_id:, user_profile_sourced_id: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @user_sourced_id = user_sourced_id
      @role_type = role_type
      @role = role
      @begin_date = begin_date
      @end_date = end_date
      @org_sourced_id = org_sourced_id
      @user_profile_sourced_id = user_profile_sourced_id
      @extension_fields = extension_fields
    end
  end
end
