# frozen_string_literal: true

module Meibo
  class ClassroomSet < DataSet
    def check_semantically_consistent
      super

      each do |classroom|
        school = roster.organizations.find(classroom.school_sourced_id)
        unless school.school?
          field = classroom.school_sourced_id
          field_info = field_info_from(classroom, :school_sourced_id)
          raise InvalidDataTypeError.new(field: field, field_info: field_info)
        end

        roster.courses.find(classroom.course_sourced_id)

        raise DataNotFoundError, "termSourcedIdは1つ以上指定してください" if classroom.term_sourced_ids.empty?

        classroom.term_sourced_ids.each do |term_sourced_id|
          roster.academic_sessions.find(term_sourced_id)
        end
      end
    end

    def homeroom
      @cache[:homeroom] ||= new(select(&:homeroom?))
    end

    def scheduled
      @cache[:scheduled] ||= new(select(&:scheduled?))
    end
  end
end
