# frozen_string_literal: true

module Meibo
  module Profiles
    profile121 = Profile.new(
      builders: {
        academic_session: Builder::AcademicSessionBuilder.create(AcademicSession),
        class: Builder::ClassroomBuilder.create(Classroom),
        course: Builder::CourseBuilder.create(Course),
        demographic: Builder::DemographicBuilder.create(Demographic),
        enrollment: Builder::EnrollmentBuilder.create(Enrollment),
        org: Builder::OrganizationBuilder.create(Organization),
        role: Builder::RoleBuilder.create(Role),
        user: Builder::UserBuilder.create(User),
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
        file_users: Meibo::User
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
      manifest_properties: { oneroster_version: "1.2.1" }
    )

    profile120 = Profile.new(
      builders: profile121.builders.merge(
        user: Builder::UserBuilder.create(UserM0)
      ),
      data_models: profile121.data_models.merge(
        file_users: UserM0
      ),
      data_set: profile121.data_set,
      manifest_properties: { oneroster_version: "1.2" }
    )

    japan_profile121_v12 = Profile.new(
      builders: {
        academic_session: Builder::AcademicSessionBuilder.create(JapanProfile::AcademicSession),
        class: Builder::ClassroomBuilder.create(JapanProfile::Classroom),
        course: Builder::CourseBuilder.create(JapanProfile::Course),
        demographic: Builder::DemographicBuilder.create(JapanProfile::Demographic),
        enrollment: Builder::EnrollmentBuilder.create(JapanProfile::Enrollment),
        org: Builder::OrganizationBuilder.create(JapanProfile::Organization),
        role: Builder::RoleBuilder.create(JapanProfile::Role),
        user: Builder::UserBuilder.create(JapanProfile::User),
        user_profile: Builder::UserProfileBuilder.create(JapanProfile::UserProfile)
      },
      data_models: {
        file_academic_sessions: JapanProfile::AcademicSession,
        file_classes: JapanProfile::Classroom,
        file_courses: JapanProfile::Course,
        file_demographics: JapanProfile::Demographic,
        file_enrollments: JapanProfile::Enrollment,
        file_orgs: JapanProfile::Organization,
        file_roles: JapanProfile::Role,
        file_user_profiles: JapanProfile::UserProfile,
        file_users: JapanProfile::User
      },
      data_set: profile121.data_set.merge(
        file_orgs: JapanProfile::OrganizationSet,
        file_users: JapanProfile::UserSet
      ),
      manifest_properties: { oneroster_version: "1.2" }
    )

    japan_profile120_v11 = Profile.new(
      builders: japan_profile121_v12.builders.merge(
        user: Builder::UserBuilder.create(JapanProfile::UserM0)
      ),
      data_models: japan_profile121_v12.data_models.merge(
        file_users: JapanProfile::UserM0
      ),
      data_set: japan_profile121_v12.data_set,
      manifest_properties: { oneroster_version: "1.2" }
    )

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
      data_set: japan_profile120_v11.data_set,
      manifest_properties: { oneroster_version: "1.2" }
    )

    PROFILES = {
      "v1.2" => profile120,
      "v1.2.1" => profile121,
      "v1.2 ep v3.00" => eportal_v3,
      "v1.2 jp v1.1" => japan_profile120_v11,
      "v1.2 jp v1.1.1" => japan_profile120_v11,
      "v1.2.1 jp v1.2" => japan_profile121_v12
    }.freeze

    def self.use(profile_name, &)
      Meibo.with_profile(self[profile_name], &)
    end

    def self.[](profile_name)
      PROFILES.fetch(profile_name)
    end
  end
end
