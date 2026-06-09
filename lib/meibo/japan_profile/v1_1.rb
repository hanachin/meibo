# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      include OneRoster::V1_2

      PROFILE = Profile.new(
        builders: ::Meibo::OneRoster::V1_2::PROFILE.builders.merge(
          academic_session: ::Meibo::Builder::AcademicSessionBuilder.create(::Meibo::JapanProfile::V1_1::AcademicSession),
          class: ::Meibo::Builder::ClassroomBuilder.create(::Meibo::JapanProfile::V1_1::Classroom),
          course: ::Meibo::Builder::CourseBuilder.create(::Meibo::JapanProfile::V1_1::Course),
          demographic: ::Meibo::Builder::DemographicBuilder.create(::Meibo::JapanProfile::V1_1::Demographic),
          enrollment: ::Meibo::Builder::EnrollmentBuilder.create(::Meibo::JapanProfile::V1_1::Enrollment),
          org: ::Meibo::Builder::OrganizationBuilder.create(::Meibo::JapanProfile::V1_1::Organization),
          user: ::Meibo::Builder::UserBuilder.create(::Meibo::JapanProfile::V1_1::User)
        ),
        data_models: ::Meibo::OneRoster::V1_2::PROFILE.data_models.merge(
          file_academic_sessions: ::Meibo::JapanProfile::V1_1::AcademicSession,
          file_classes: ::Meibo::JapanProfile::V1_1::Classroom,
          file_courses: ::Meibo::JapanProfile::V1_1::Course,
          file_demographics: ::Meibo::JapanProfile::V1_1::Demographic,
          file_enrollments: ::Meibo::JapanProfile::V1_1::Enrollment,
          file_orgs: ::Meibo::JapanProfile::V1_1::Organization,
          file_users: ::Meibo::JapanProfile::V1_1::User
        ),
        data_set: ::Meibo::OneRoster::V1_2::PROFILE.data_set.merge(
          file_orgs: ::Meibo::JapanProfile::V1_1::OrganizationSet,
          file_users: ::Meibo::JapanProfile::V1_1::UserSet
        ),
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
