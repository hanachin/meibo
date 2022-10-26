# frozen_string_literal: true

module Meibo
  class Course
    Data.define(
      self,
      filename: 'courses.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        school_year_sourced_id: 'schoolYearSourcedId',
        title: 'title',
        course_code: 'courseCode',
        grades: 'grades',
        org_sourced_id: 'orgSourcedId',
        subjects: 'subjects',
        subject_codes: 'subjectCodes'
      },
      converters: {
        list: [:grades, :subjects, :subject_codes]
      }
    )

    # NOTE: courseCodeは空文字固定
    def initialize(sourced_id:, school_year_sourced_id: nil, title:, course_code: '', grades: [], org_sourced_id:, subjects: [], subject_codes: [])
      @sourced_id = sourced_id
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
