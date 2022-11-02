# frozen_string_literal: true

module Meibo
  class Course
    DataModel.define(
      self,
      filename: 'courses.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        school_year_sourced_id: 'schoolYearSourcedId',
        title: 'title',
        course_code: 'courseCode',
        grades: 'grades',
        org_sourced_id: 'orgSourcedId',
        subjects: 'subjects',
        subject_codes: 'subjectCodes'
      },
      converters: {
        datetime: [:date_last_modified],
        list: [:grades, :subjects, :subject_codes]
      },
      validation: {
        required: [:sourced_id, :title, :org_sourced_id]
      }
    )

    # NOTE: courseCodeは空文字固定
    def initialize(sourced_id:, status: nil, date_last_modified: nil, school_year_sourced_id: nil, title:, course_code: '', grades: [], org_sourced_id:, subjects: [], subject_codes: [])
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
    end
  end
end
