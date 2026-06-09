# frozen_string_literal: true

module Meibo
  module OneRoster
    module V1_2
      AcademicSession = ::Meibo::AcademicSession
      AcademicSessionSet = ::Meibo::AcademicSessionSet
      Classroom = ::Meibo::Classroom
      ClassroomSet = ::Meibo::ClassroomSet
      Course = ::Meibo::Course
      CourseSet = ::Meibo::CourseSet
      Demographic = ::Meibo::Demographic
      DemographicSet = ::Meibo::DemographicSet
      Enrollment = ::Meibo::Enrollment
      EnrollmentSet = ::Meibo::EnrollmentSet
      Organization = ::Meibo::Organization
      OrganizationSet = ::Meibo::OrganizationSet
      Role = ::Meibo::Role
      RoleSet = ::Meibo::RoleSet
      UserM0 = ::Meibo::UserM0
      UserSet = ::Meibo::UserSet
      UserProfile = ::Meibo::UserProfile
      UserProfileSet = ::Meibo::UserProfileSet

      PROFILE = Profile.new(
        builders: {
          academic_session: Builder::AcademicSessionBuilder.create(::Meibo::OneRoster::V1_2::AcademicSession),
          class: Builder::ClassroomBuilder.create(::Meibo::OneRoster::V1_2::Classroom),
          course: Builder::CourseBuilder.create(::Meibo::OneRoster::V1_2::Course),
          demographic: Builder::DemographicBuilder.create(::Meibo::OneRoster::V1_2::Demographic),
          enrollment: Builder::EnrollmentBuilder.create(::Meibo::OneRoster::V1_2::Enrollment),
          org: Builder::OrganizationBuilder.create(::Meibo::OneRoster::V1_2::Organization),
          role: Builder::RoleBuilder.create(::Meibo::OneRoster::V1_2::Role),
          user: Builder::UserBuilder.create(::Meibo::OneRoster::V1_2::UserM0),
          user_profile: Builder::UserProfileBuilder.create(::Meibo::OneRoster::V1_2::UserProfile)
        },
        data_models: {
          file_academic_sessions: ::Meibo::OneRoster::V1_2::AcademicSession,
          file_classes: ::Meibo::OneRoster::V1_2::Classroom,
          file_courses: ::Meibo::OneRoster::V1_2::Course,
          file_demographics: ::Meibo::OneRoster::V1_2::Demographic,
          file_enrollments: ::Meibo::OneRoster::V1_2::Enrollment,
          file_orgs: ::Meibo::OneRoster::V1_2::Organization,
          file_roles: ::Meibo::OneRoster::V1_2::Role,
          file_user_profiles: ::Meibo::OneRoster::V1_2::UserProfile,
          file_users: ::Meibo::OneRoster::V1_2::UserM0
        },
        data_set: {
          file_academic_sessions: ::Meibo::OneRoster::V1_2::AcademicSessionSet,
          file_classes: ::Meibo::OneRoster::V1_2::ClassroomSet,
          file_courses: ::Meibo::OneRoster::V1_2::CourseSet,
          file_demographics: ::Meibo::OneRoster::V1_2::DemographicSet,
          file_enrollments: ::Meibo::OneRoster::V1_2::EnrollmentSet,
          file_orgs: ::Meibo::OneRoster::V1_2::OrganizationSet,
          file_roles: ::Meibo::OneRoster::V1_2::RoleSet,
          file_user_profiles: ::Meibo::OneRoster::V1_2::UserProfileSet,
          file_users: ::Meibo::OneRoster::V1_2::UserSet
        },
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
