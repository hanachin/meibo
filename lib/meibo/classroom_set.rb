# frozen_string_literal: true

module Meibo
  class ClassroomSet < DataSet
    def initialize(data, academic_session_set:, course_set:, organization_set:)
      super(data)
      @academic_session_set = academic_session_set
      @course_set = course_set
      @organization_set = organization_set
    end

    def check_semantically_consistent
      super

      each do |classroom|
        @organization_set.find_by_sourced_id(classroom.school_sourced_id)
        @course_set.find_by_sourced_id(classroom.course_sourced_id)

        if classroom.term_sourced_ids.empty?
          raise DataNotFoundError, "termSourcedIdは1つ以上指定してください"
        end

        classroom.term_sourced_ids.each do |term_sourced_id|
          @academic_session_set.find_by_sourced_id(term_sourced_id)
        end
      end
    end
  end
end
