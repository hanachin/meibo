# frozen_string_literal: true

module Meibo
  class AcademicSession
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
      },
      converters: {
        academic_session_type: [:type],
        date: [:start_date, :end_date],
        datetime: [:date_last_modified],
        required: [:sourced_id, :title, :type, :start_date, :end_date, :school_year],
        status: [:status],
        year: [:school_year]
      }
    )

    TYPES = {
      grading_period: 'gradingPeriod',
      semester: 'semester',
      school_year: 'schoolYear',
      term: 'term'
    }.freeze

    # NOTE: 以下固定
    #   - titleは連携処理実行時の対象年度西暦 + 「年度」を設定
    #   - typeはschoolYear固定
    #   - start_dateは対象年度の開始日固定
    #   - end_dateは対象年度の終了日固定
    def initialize(sourced_id:, status: nil, date_last_modified: nil, school_year:, title: "#{school_year}年度", type: TYPES[:school_year], start_date: Date.new(school_year, 4, 1), end_date: Date.new(school_year + 1, 3, 31), parent_sourced_id: nil)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @title = title
      @type = type
      @start_date = start_date
      @end_date = end_date
      @parent_sourced_id = parent_sourced_id
      @school_year = school_year
    end
  end
end
