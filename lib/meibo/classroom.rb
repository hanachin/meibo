# frozen_string_literal: true

module Meibo
  class Classroom
    Data.define(
      self,
      filename: 'classes.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        title: 'title',
        grades: 'grades',
        course_sourced_id: 'courseSourcedId',
        class_code: 'classCode',
        class_type: 'classType',
        location: 'location',
        school_sourced_id: 'schoolSourcedId',
        term_sourced_ids: 'termSourcedIds',
        subjects: 'subjects',
        subject_codes: 'subjectCodes',
        periods: 'periods',
        special_needs: 'metadata.jp.specialNeeds'
      },
      converters: {
        boolean: [:special_needs],
        list: [
          :grades,
          :term_sourced_ids,
          :subjects,
          :subject_codes,
          :periods
        ]
      }
    )

    TYPES = {
      homeroom: 'homeroom',
      scheduled: 'scheduled'
    }.freeze

    def initialize(sourced_id:, title:, grades: [], course_sourced_id:, class_code: nil, class_type:, location: nil, school_sourced_id:, term_sourced_ids:, subjects: [], subject_codes: [], periods: [], special_needs: nil)
      @sourced_id = sourced_id
      @title = title
      @grades = grades
      @course_sourced_id = course_sourced_id
      @class_code = class_code
      @class_type = class_type
      @location = location
      @school_sourced_id = school_sourced_id
      @term_sourced_ids = term_sourced_ids
      @subjects = subjects
      @subject_codes = subject_codes
      @periods = periods
      @special_needs = special_needs
    end
  end
end
