# frozen_string_literal: true

module Meibo
  class Enrollment
    include DataModel

    ROLES = {
      administrator: "administrator",
      proctor: "proctor",
      student: "student",
      teacher: "teacher"
    }.freeze

    define_attributes(
      sourced_id: "sourcedId",
      status: "status",
      date_last_modified: "dateLastModified",
      class_sourced_id: "classSourcedId",
      school_sourced_id: "schoolSourcedId",
      user_sourced_id: "userSourcedId",
      role: "role",
      primary: "primary",
      begin_date: "beginDate",
      end_date: "endDate"
    )

    define_converters(
      boolean: [:primary],
      date: %i[begin_date end_date],
      datetime: [:date_last_modified],
      enum: { role: [*ROLES.values, ENUM_EXT_PATTERN] },
      required: %i[sourced_id class_sourced_id school_sourced_id user_sourced_id role],
      status: [:status]
    )

    def initialize(sourced_id:, class_sourced_id:, school_sourced_id:, user_sourced_id:, role:, status: nil,
                   date_last_modified: nil, primary: nil, begin_date: nil, end_date: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @primary = primary
      @class_sourced_id = class_sourced_id
      @school_sourced_id = school_sourced_id
      @user_sourced_id = user_sourced_id
      @role = role
      @begin_date = begin_date
      @end_date = end_date
      @extension_fields = extension_fields
    end

    def collection
      Meibo.current_roster.enrollments
    end

    def administrator?
      role == ROLES[:administrator]
    end

    def proctor?
      role == ROLES[:proctor]
    end

    def student?
      role == ROLES[:student]
    end

    def teacher?
      role == ROLES[:teacher]
    end

    def classroom
      Meibo.current_roster.classes.find(class_sourced_id)
    end

    def school
      Meibo.current_roster.organizations.find(school_sourced_id)
    end

    def user
      Meibo.current_roster.users.find(user_sourced_id)
    end
  end
end
