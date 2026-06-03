# frozen_string_literal: true

module Meibo
  module JapanProfile::V1_2_Ed2
    class AcademicSession < ::Meibo::AcademicSession
      TYPES = { school_year: "schoolYear" }.freeze

      converters = superclass.converters.merge(
        format: { title: /\A\d+年度\z/ },
        enum: { type: TYPES.values }
      )

      define_converters(converters)

      # NOTE: 以下固定
      #   - titleは連携処理実行時の対象年度西暦 + 「年度」を設定
      #   - typeはschoolYear固定
      #   - start_dateは対象年度の開始日固定
      #   - end_dateは対象年度の終了日固定
      def initialize(school_year:, title: "#{school_year}年度", type: TYPES[:school_year],
                     start_date: Date.new(school_year, 4,
                                          1), end_date: Date.new(school_year + 1, 3, 31), **other_fields)
        super
      end
    end
  end
end
