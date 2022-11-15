# frozen_string_literal: true

module Meibo
  class AcademicSessionSet < DataSet
    def check_semantically_consistent
      super

      each do |academic_session|
        next unless academic_session.parent_sourced_id

        find(academic_session.parent_sourced_id)
      end
    end

    def grading_period
      @cache[:grading_period] ||= new(select(&:grading_period?))
    end

    def semester
      @cache[:semester] ||= new(select(&:semester?))
    end

    def school_year
      @cache[:school_year] ||= new(select(&:school_year?))
    end

    def term
      @cache[:term] ||= new(select(&:term?))
    end
  end
end
