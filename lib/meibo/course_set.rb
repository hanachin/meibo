# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def check_semantically_consistent
      super

      each do |course|
        roster.academic_sessions.school_year.find(course.school_year_sourced_id) if course.school_year_sourced_id

        roster.organizations.find(course.org_sourced_id)
      end
    end
  end
end
