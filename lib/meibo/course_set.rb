# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def initialize(data, academic_session_set:, organization_set:)
      super(data)
      @academic_session_set = academic_session_set
      @organization_set = organization_set
    end

    def check_semantically_consistent
      super

      each do |course|
        if course.school_year_sourced_id
          @academic_session_set.find_by_sourced_id(course.school_year_sourced_id)
        end

        @organization_set.find_by_sourced_id(course.org_sourced_id)
      end
    end
  end
end
