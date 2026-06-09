# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      PROFILE = Profile.new(
        builders: ::Meibo::OneRoster::V1_2::PROFILE.builders.merge(
          academic_session: Builder::AcademicSessionBuilder.create(::Meibo::JapanProfile::AcademicSession),
          class: Builder::ClassroomBuilder.create(::Meibo::JapanProfile::Classroom),
          course: Builder::CourseBuilder.create(::Meibo::JapanProfile::Course),
          demographic: Builder::DemographicBuilder.create(::Meibo::JapanProfile::Demographic),
          enrollment: Builder::EnrollmentBuilder.create(::Meibo::JapanProfile::Enrollment),
          org: Builder::OrganizationBuilder.create(::Meibo::JapanProfile::Organization),
          user: Builder::UserBuilder.create(::Meibo::JapanProfile::UserM0)
        ),
        data_models: ::Meibo::OneRoster::V1_2::PROFILE.data_models.merge(
          file_academic_sessions: ::Meibo::JapanProfile::AcademicSession,
          file_classes: ::Meibo::JapanProfile::Classroom,
          file_courses: ::Meibo::JapanProfile::Course,
          file_demographics: ::Meibo::JapanProfile::Demographic,
          file_enrollments: ::Meibo::JapanProfile::Enrollment,
          file_orgs: ::Meibo::JapanProfile::Organization,
          file_users: ::Meibo::JapanProfile::UserM0
        ),
        data_set: ::Meibo::OneRoster::V1_2::PROFILE.data_set.merge(
          file_orgs: ::Meibo::JapanProfile::OrganizationSet,
          file_users: ::Meibo::JapanProfile::UserSet
        ),
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
