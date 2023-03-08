# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def check_semantically_consistent
      super

      each do |course|
        if course.school_year_sourced_id
          school_year = roster.academic_sessions.find(course.school_year_sourced_id)

          raise InvalidDataTypeError unless school_year.school_year?
        end

        roster.organizations.find(course.org_sourced_id)
      end
    end
  end
end
