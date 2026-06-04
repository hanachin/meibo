# frozen_string_literal: true

module Meibo
  module OneRoster
    module V1_2
      PROFILE = Profile.new(
        builders: {
          academic_session: Builder::AcademicSessionBuilder.create(AcademicSession),
          class: Builder::ClassroomBuilder.create(Classroom),
          course: Builder::CourseBuilder.create(Course),
          demographic: Builder::DemographicBuilder.create(Demographic),
          enrollment: Builder::EnrollmentBuilder.create(Enrollment),
          org: Builder::OrganizationBuilder.create(Organization),
          role: Builder::RoleBuilder.create(Role),
          user: Builder::UserBuilder.create(UserM0),
          user_profile: Builder::UserProfileBuilder.create(UserProfile)
        },
        data_models: {
          file_academic_sessions: Meibo::AcademicSession,
          file_classes: Meibo::Classroom,
          file_courses: Meibo::Course,
          file_demographics: Meibo::Demographic,
          file_enrollments: Meibo::Enrollment,
          file_orgs: Meibo::Organization,
          file_roles: Meibo::Role,
          file_user_profiles: Meibo::UserProfile,
          file_users: Meibo::UserM0
        },
        data_set: {
          file_academic_sessions: Meibo::AcademicSessionSet,
          file_classes: Meibo::ClassroomSet,
          file_courses: Meibo::CourseSet,
          file_demographics: Meibo::DemographicSet,
          file_enrollments: Meibo::EnrollmentSet,
          file_orgs: Meibo::OrganizationSet,
          file_roles: Meibo::RoleSet,
          file_user_profiles: Meibo::UserProfileSet,
          file_users: Meibo::UserSet
        },
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
