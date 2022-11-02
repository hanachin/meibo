# frozen_string_literal: true

module Meibo
  class AcademicSession
    TYPES = {
      grading_period: 'gradingPeriod',
      semester: 'semester',
      school_year: 'schoolYear',
      term: 'term'
    }.freeze

    DataModel.define(
      self,
      filename: 'academicSessions.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        title: 'title',
        type: 'type',
        start_date: 'startDate',
        end_date: 'endDate',
        parent_sourced_id: 'parentSourcedId',
        school_year: 'schoolYear'
      }.freeze,
      converters: {
        enum: { type: [*TYPES.values.freeze, ENUM_EXT_PATTERN] }.freeze,
        date: [:start_date, :end_date].freeze,
        datetime: [:date_last_modified].freeze,
        required: [:sourced_id, :title, :type, :start_date, :end_date, :school_year].freeze,
        status: [:status].freeze,
        year: [:school_year].freeze
      }.freeze
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, school_year:, title: nil, type:, start_date:, end_date:, parent_sourced_id: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @title = title
      @type = type
      @start_date = start_date
      @end_date = end_date
      @parent_sourced_id = parent_sourced_id
      @school_year = school_year
      @extension_fields = extension_fields
    end
  end
end
