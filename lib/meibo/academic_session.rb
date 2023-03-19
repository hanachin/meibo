# frozen_string_literal: true

module Meibo
  class AcademicSession
    include DataModel

    TYPES = {
      grading_period: "gradingPeriod",
      semester: "semester",
      school_year: "schoolYear",
      term: "term"
    }.freeze

    define_attributes(
      sourced_id: "sourcedId",
      status: "status",
      date_last_modified: "dateLastModified",
      title: "title",
      type: "type",
      start_date: "startDate",
      end_date: "endDate",
      parent_sourced_id: "parentSourcedId",
      school_year: "schoolYear"
    )

    define_converters(
      enum: { type: [*TYPES.values, ENUM_EXT_PATTERN] },
      date: %i[start_date end_date],
      datetime: [:date_last_modified],
      required: %i[sourced_id title type start_date end_date school_year],
      status: [:status],
      year: [:school_year]
    )

    def initialize(sourced_id:, school_year:, type:, start_date:, end_date:, status: nil, date_last_modified: nil,
                   title: nil, parent_sourced_id: nil, **extension_fields)
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

    def collection
      Meibo.current_roster.academic_sessions
    end

    def grading_period?
      type == TYPES[:grading_period]
    end

    def semester?
      type == TYPES[:semester]
    end

    def school_year?
      type == TYPES[:school_year]
    end

    def term?
      type == TYPES[:term]
    end

    def parent
      parent_sourced_id && collection.find(parent_sourced_id)
    end

    def children
      collection.where(parent_sourced_id: sourced_id)
    end
  end
end
