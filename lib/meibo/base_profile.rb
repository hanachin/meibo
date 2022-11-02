# frozen_string_literal: true

module Meibo
  module BaseProfile
    BUILDERS = {
      academic_session: Builder::AcademicSessionBuilder.create(AcademicSession),
      class: Builder::ClassroomBuilder.create(Classroom),
      course: Builder::CourseBuilder.create(Course),
      demographic: Builder::DemographicBuilder.create(Demographic),
      enrollment: Builder::EnrollmentBuilder.create(Enrollment),
      org: Builder::OrganizationBuilder.create(Organization),
      role: Builder::RoleBuilder.create(Role),
      user: Builder::UserBuilder.create(User),
      user_profile: Builder::UserProfileBuilder.create(UserProfile)
    }

    DATA_MODELS = {
      file_academic_sessions: Meibo::AcademicSession,
      file_classes: Meibo::Classroom,
      file_courses: Meibo::Course,
      file_demographics: Meibo::Demographic,
      file_enrollments: Meibo::Enrollment,
      file_orgs: Meibo::Organization,
      file_roles: Meibo::Role,
      file_user_profiles: Meibo::UserProfile,
      file_users: Meibo::User
    }

    def self.builder_for(key)
      BUILDERS[key]
    end

    def self.data_model_for(file_attribute)
      DATA_MODELS[file_attribute]
    end
  end
end
