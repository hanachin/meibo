# frozen_string_literal: true

module Meibo
  class EnrollmentSet < DataSet
    def check_semantically_consistent
      super

      each do |enrollment|
        roster.classes.find(enrollment.class_sourced_id)
        roster.organizations.find(enrollment.school_sourced_id)
        roster.users.find(enrollment.user_sourced_id)
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
