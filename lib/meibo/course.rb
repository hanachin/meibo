# frozen_string_literal: true

module Meibo
  class Course
    DataModel.define(
      self,
      attribute_name_to_header_field_map: {
        sourced_id: "sourcedId",
        status: "status",
        date_last_modified: "dateLastModified",
        school_year_sourced_id: "schoolYearSourcedId",
        title: "title",
        course_code: "courseCode",
        grades: "grades",
        org_sourced_id: "orgSourcedId",
        subjects: "subjects",
        subject_codes: "subjectCodes"
      },
      converters: {
        datetime: [:date_last_modified],
        list: %i[grades subjects subject_codes],
        required: %i[sourced_id title org_sourced_id],
        status: [:status]
      }
    )

    def initialize(sourced_id:, title:, org_sourced_id:, status: nil, date_last_modified: nil, school_year_sourced_id: nil,
                   course_code: nil, grades: [], subjects: [], subject_codes: [], **extension_fields)
      raise InvalidDataTypeError unless subjects.is_a?(Array) && subject_codes.is_a?(Array) && subjects.size == subject_codes.size

      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @school_year_sourced_id = school_year_sourced_id
      @title = title
      @course_code = course_code
      @grades = grades
      @org_sourced_id = org_sourced_id
      @subjects = subjects
      @subject_codes = subject_codes
      @extension_fields = extension_fields
    end

    def collection
      Meibo.current_roster.courses
    end

    def organization
      Meibo.current_roster.organizations.find(org_sourced_id)
    end

    def school_year
      Meibo.current_roster.academic_sessions.find(school_year_sourced_id)
    end

    def classes
      Meibo.current_roster.classes.where(course_sourced_id: sourced_id)
    end
  end
end
