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
  end
end
