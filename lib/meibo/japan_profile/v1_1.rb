# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
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
          file_academic_sessions: AcademicSession,
          file_classes: Classroom,
          file_courses: Course,
          file_demographics: Demographic,
          file_enrollments: Enrollment,
          file_orgs: Organization,
          file_roles: Role,
          file_user_profiles: UserProfile,
          file_users: UserM0
        },
        data_set: OneRoster::V1_2::PROFILE.data_set.merge(
          file_orgs: OrganizationSet,
          file_users: UserSet
        ),
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
