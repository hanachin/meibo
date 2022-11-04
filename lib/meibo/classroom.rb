# frozen_string_literal: true

module Meibo
  class Classroom
    TYPES = {
      homeroom: 'homeroom',
      scheduled: 'scheduled'
    }.freeze

    DataModel.define(
      self,
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
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
        periods: 'periods'
      }.freeze,
      converters: {
        datetime: [:date_last_modified].freeze,
        enum: {
          class_type: [*TYPES.values, ENUM_EXT_PATTERN].freeze
        }.freeze,
        list: [
          :grades,
          :term_sourced_ids,
          :subjects,
          :subject_codes,
          :periods
        ].freeze,
        required: [:sourced_id, :title, :class_type, :course_sourced_id, :term_sourced_ids, :school_sourced_id].freeze,
        status: [:status].freeze
      }
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, title:, grades: [], course_sourced_id:, class_code: nil, class_type:, location: nil, school_sourced_id:, term_sourced_ids:, subjects: [], subject_codes: [], periods: [], **extension_fields)
      unless subjects.is_a?(Array) && subject_codes.is_a?(Array) && subjects.size == subject_codes.size
        raise InvalidDataTypeError
      end

      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
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
      @extension_fields = extension_fields
    end

    def homeroom?
      class_type == TYPES[:homeroom]
    end

    def scheduled?
      class_type == TYPES[:scheduled]
    end
  end
end
