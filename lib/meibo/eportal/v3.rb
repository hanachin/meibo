# frozen_string_literal: true

module Meibo
  module Eportal
    module V3
      PROFILE = Profile.new(
        builders: ::Meibo::JapanProfile::V1_2::PROFILE.builders.merge(
          class: Builder::ClassroomBuilder.create(::Meibo::Eportal::V3::Classroom),
          course: Builder::CourseBuilder.create(::Meibo::Eportal::V3::Course),
          enrollment: Builder::EnrollmentBuilder.create(::Meibo::Eportal::V3::Enrollment),
          org: Builder::OrganizationBuilder.create(::Meibo::Eportal::V3::Organization),
          user_profile: Builder::UserProfileBuilder.create(::Meibo::Eportal::V3::UserProfile),
          user: Builder::UserBuilder.create(::Meibo::Eportal::V3::User)
        ),
        data_models: ::Meibo::JapanProfile::V1_2::PROFILE.data_models.merge(
          file_classes: ::Meibo::Eportal::V3::Classroom,
          file_courses: ::Meibo::Eportal::V3::Course,
          file_enrollments: ::Meibo::Eportal::V3::Enrollment,
          file_orgs: ::Meibo::Eportal::V3::Organization,
          file_user_profiles: ::Meibo::Eportal::V3::UserProfile,
          file_users: ::Meibo::Eportal::V3::User
        ),
        data_set: ::Meibo::JapanProfile::V1_2::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2" }
      )
    end
  end
end
