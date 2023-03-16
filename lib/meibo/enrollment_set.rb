# frozen_string_literal: true

module Meibo
  class EnrollmentSet < DataSet
    def check_semantically_consistent
      super

      each do |enrollment|
        roster.classes.find(enrollment.class_sourced_id)
        school = roster.organizations.find(enrollment.school_sourced_id)

        unless school.school?
          field = enrollment.school_sourced_id
          field_info = field_info_from(enrollment, :school_sourced_id)
          raise InvalidDataTypeError.new(field: field, field_info: field_info)
        end

        roster.users.find(enrollment.user_sourced_id)
        next if !enrollment.primary || enrollment.teacher?

        raise InvalidDataTypeError.new(field: enrollment.primary, field_info: field_info_from(enrollment, :primary))
      end
    end

    def administrator
      @cache[:administrator] ||= new(select(&:administrator?))
    end

    def proctor
      @cache[:proctor] ||= new(select(&:proctor?))
    end

    def student
      @cache[:student] ||= new(select(&:student?))
    end

    def teacher
      @cache[:teacher] ||= new(select(&:teacher?))
    end
  end
end
