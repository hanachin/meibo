# frozen_string_literal: true

module Meibo
  module Profiles
    eportal_v3 = Profile.new(
      builders: {
        academic_session: Builder::AcademicSessionBuilder.create(Eportal::V3::AcademicSession),
        class: Builder::ClassroomBuilder.create(Eportal::V3::Classroom),
        course: Builder::CourseBuilder.create(Eportal::V3::Course),
        demographic: Builder::DemographicBuilder.create(Eportal::V3::Demographic),
        enrollment: Builder::EnrollmentBuilder.create(Eportal::V3::Enrollment),
        organization: Builder::OrganizationBuilder.create(Eportal::V3::Organization),
        role: Builder::RoleBuilder.create(Eportal::V3::Role),
        user_profile: Builder::UserProfileBuilder.create(Eportal::V3::UserProfile),
        user: Builder::UserBuilder.create(Eportal::V3::User)
      },
      data_models: {
        file_academic_sessions: Eportal::V3::AcademicSession,
        file_classes: Eportal::V3::Classroom,
        file_courses: Eportal::V3::Course,
        file_demographics: Eportal::V3::Demographic,
        file_enrollments: Eportal::V3::Enrollment,
        file_orgs: Eportal::V3::Organization,
        file_roles: Eportal::V3::Role,
        file_user_profiles: Eportal::V3::UserProfile,
        file_users: Eportal::V3::User
      },
      data_set: JapanProfile::V1_1::PROFILE.data_set,
      manifest_properties: { oneroster_version: "1.2" }
    )

    PROFILES = {
      "v1.2" => OneRoster::V1_2::PROFILE,
      "v1.2.1" => OneRoster::V1_2_1::PROFILE,
      "v1.2 ep v3.00" => eportal_v3,
      "v1.2 jp v1.1" => JapanProfile::V1_1::PROFILE,
      "v1.2 jp v1.1.1" => JapanProfile::V1_1_1::PROFILE,
      "v1.2.1 jp v1.2" => JapanProfile::V1_2::PROFILE,
      "v1.2.1 ep v4.00" => Meibo::Eportal::V4::PROFILE
    }.freeze

    def self.use(profile_name, &)
      Meibo.with_profile(self[profile_name], &)
    end

    def self.[](profile_name)
      PROFILES.fetch(profile_name)
    end
  end
end
