# frozen_string_literal: true

require 'forwardable'

module Meibo
  module JapanProfile
    class Builder < ::Meibo::Builder
      BUILDERS = {
        academic_session: AcademicSessionBuilder.create(AcademicSession),
        classroom: ClassroomBuilder.create(Classroom),
        course: CourseBuilder.create(Course),
        demographic: DemographicBuilder.create(Demographic),
        enrollment: EnrollmentBuilder.create(Enrollment),
        organization: OrganizationBuilder.create(Organization),
        role: RoleBuilder.create(Role),
        user: UserBuilder.create(User),
        user_profile: UserProfileBuilder.create(UserProfile)
      }

      private

      def builder_for(key)
        BUILDERS[key]
      end
    end
  end
end
