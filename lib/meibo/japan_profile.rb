# frozen_string_literal: true

module Meibo
  module JapanProfile
    include BaseProfile

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
      file_academic_sessions: Meibo::JapanProfile::AcademicSession,
      file_classes: Meibo::JapanProfile::Classroom,
      file_courses: Meibo::JapanProfile::Course,
      file_demographics: Meibo::JapanProfile::Demographic,
      file_enrollments: Meibo::JapanProfile::Enrollment,
      file_orgs: Meibo::JapanProfile::Organization,
      file_roles: Meibo::JapanProfile::Role,
      file_user_profiles: Meibo::JapanProfile::UserProfile,
      file_users: Meibo::JapanProfile::User
    }

    def self.builder_for(key)
      BUILDERS[key]
    end

    def self.data_model_for(file_attribute)
      DATA_MODELS[file_attribute]
    end
  end
end
