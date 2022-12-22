# frozen_string_literal: true

module Meibo
  class Role
    # @type var types: ::Meibo::Role::role_types
    types = {
      primary: "primary",
      secondary: "secondary"
    }
    types.freeze
    TYPES = types

    # @type var roles: ::Meibo::Role::roles
    roles = {
      aide: "aide",
      counselor: "counselor",
      district_administrator: "districtAdministrator",
      guardian: "guardian",
      parent: "parent",
      principal: "principal",
      proctor: "proctor",
      relative: "relative",
      site_administrator: "siteAdministrator",
      student: "student",
      system_administrator: "systemAdministrator",
      teacher: "teacher"
    }
    roles.freeze
    ROLES = roles

    DataModel.define(
      self,
      attribute_name_to_header_field_map: {
        sourced_id: "sourcedId",
        status: "status",
        date_last_modified: "dateLastModified",
        user_sourced_id: "userSourcedId",
        role_type: "roleType",
        role: "role",
        begin_date: "beginDate",
        end_date: "endDate",
        org_sourced_id: "orgSourcedId",
        user_profile_sourced_id: "userProfileSourcedId"
      }.freeze,
      converters: {
        date: %i[begin_date end_date].freeze,
        datetime: [:date_last_modified].freeze,
        required: %i[sourced_id user_sourced_id role_type role org_sourced_id].freeze,
        enum: {
          role: [*ROLES.values, ENUM_EXT_PATTERN].freeze,
          role_type: TYPES.values.freeze
        }.freeze,
        status: [:status].freeze
      }.freeze
    )

    def initialize(sourced_id:, user_sourced_id:, role_type:, role:, org_sourced_id:, status: nil, date_last_modified: nil,
                   begin_date: nil, end_date: nil, user_profile_sourced_id: nil, **extension_fields)
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

    def collection
      Meibo.current_roster.roles
    end

    def primary?
      @role_type == TYPES[:primary]
    end

    def secondary?
      @role_type == TYPES[:secondary]
    end

    def aide?
      role == ROLES[:aide]
    end

    def counselor?
      role == ROLES[:counselor]
    end

    def district_administrator?
      role == ROLES[:district_administrator]
    end

    def guardian?
      role == ROLES[:guardian]
    end

    def parent?
      role == ROLES[:parent]
    end

    def principal?
      role == ROLES[:principal]
    end

    def proctor?
      role == ROLES[:proctor]
    end

    def relative?
      role == ROLES[:relative]
    end

    def site_administrator?
      role == ROLES[:site_administrator]
    end

    def student?
      role == ROLES[:student]
    end

    def system_administrator?
      role == ROLES[:system_administrator]
    end

    def teacher?
      role == ROLES[:teacher]
    end

    def organization
      Meibo.current_roster.organizations.find(org_sourced_id)
    end

    def user
      Meibo.current_roster.users.find(user_sourced_id)
    end

    def user_profile
      user_profile_sourced_id && Meibo.current_roster.user_profiles.find(user_profile_sourced_id)
    end
  end
end
