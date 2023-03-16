# frozen_string_literal: true

module Meibo
  class CourseSet < DataSet
    def check_semantically_consistent
      super

      each do |course|
        if course.school_year_sourced_id
          school_year = roster.academic_sessions.find(course.school_year_sourced_id)

          unless school_year.school_year?
            field = school_year_sourced_id
            field_info = field_info_from(course, :school_year_sourced_id)
            raise InvalidDataTypeError.new(field: field, field_info: field_info)
          end
        end

        roster.organizations.find(course.org_sourced_id)
      end
    end
  end
end
