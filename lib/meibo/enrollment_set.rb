# frozen_string_literal: true

module Meibo
  class EnrollmentSet < DataSet
    def initialize(data, classroom_set:, organization_set:, user_set:)
      super(data)
      @classroom_set = classroom_set
      @organization_set = organization_set
      @user_set = user_set
    end

    def check_semantically_consistent
      super

      each do |enrollment|
        @classroom_set.find_by_sourced_id(enrollment.class_sourced_id)
        @organization_set.find_by_sourced_id(enrollment.school_sourced_id)
        @user_set.find_by_sourced_id(enrollment.user_sourced_id)
      end
    end
  end
end
