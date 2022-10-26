# frozen_string_literal: true

require 'securerandom'

module Meibo
  class Builder
    class EnrollmentBuilder < Enrollment
      attr_reader :builder, :classroom, :school, :user

      def initialize(builder:, sourced_id: SecureRandom.uuid, classroom:, school:, user:, **kw)
        super(
          sourced_id: sourced_id,
          class_sourced_id: classroom.sourced_id,
          school_sourced_id: school.sourced_id,
          user_sourced_id: user.sourced_id,
          **kw
        )
        @builder = builder
        @classroom = classroom
        @school = school
        @user = user
        builder.enrollments << self
      end
    end
  end
end
