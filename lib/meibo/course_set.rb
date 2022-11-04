# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def check_semantically_consistent
      super

      each do |course|
        if course.school_year_sourced_id
          roster.academic_sessions.find(course.school_year_sourced_id)
        end

        roster.organizations.find(course.org_sourced_id)
      end
    end
  end
end
