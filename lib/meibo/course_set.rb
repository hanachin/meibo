# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def check_semantically_consistent
      super

      each do |course|
        if course.school_year_sourced_id
          roster.academic_sessions.find_by_sourced_id(course.school_year_sourced_id)
        end

        roster.organizations.find_by_sourced_id(course.org_sourced_id)
      end
    end
  end
end
