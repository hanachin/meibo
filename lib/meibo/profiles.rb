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
      }
    )

    profile120 = Profile.new(
      builders: profile121.builders.merge(
        user: Builder::UserBuilder.create(UserM0)
      ),
      data_models: profile121.data_models.merge(
        file_users: UserM0
      ),
      data_set: profile121.data_set
    )

    japan_profile121_v11 = Profile.new(
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
      )
    )

    japan_profile120_v11 = Profile.new(
      builders: japan_profile121_v11.builders.merge(
        user: Builder::UserBuilder.create(JapanProfile::UserM0)
      ),
      data_models: japan_profile121_v11.data_models.merge(
        file_users: JapanProfile::UserM0
      ),
      data_set: japan_profile121_v11.data_set
    )

    japan_profile120_v10 = Profile.new(
      builders: japan_profile120_v11.builders.merge(
        role: Builder::UserBuilder.create(JapanProfile::RoleJpM0)
      ),
      data_models: japan_profile120_v11.data_models.merge(
        file_roles: JapanProfile::RoleJpM0
      ),
      data_set: japan_profile120_v11.data_set
    )

    eportal_v3 = Profile.new(
      builders: {
        academic_session: Builder::AcademicSessionBuilder.create(EportalV3::AcademicSession),
        class: Builder::ClassroomBuilder.create(EportalV3::Classroom),
        course: Builder::CourseBuilder.create(EportalV3::Course),
        demographic: Builder::DemographicBuilder.create(EportalV3::Demographic),
        enrollment: Builder::EnrollmentBuilder.create(EportalV3::Enrollment),
        organization: Builder::OrganizationBuilder.create(EportalV3::Organization),
        role: Builder::RoleBuilder.create(EportalV3::Role),
        user_profile: Builder::UserProfileBuilder.create(EportalV3::UserProfile),
        user: Builder::UserBuilder.create(EportalV3::User)
      },
      data_models: {
        file_academic_sessions: EportalV3::AcademicSession,
        file_classes: EportalV3::Classroom,
        file_courses: EportalV3::Course,
        file_demographics: EportalV3::Demographic,
        file_enrollments: EportalV3::Enrollment,
        file_orgs: EportalV3::Organization,
        file_roles: EportalV3::Role,
        file_user_profiles: EportalV3::UserProfile,
        file_users: EportalV3::User
      },
      data_set: japan_profile120_v11.data_set
    )

    PROFILES = {
      "v1.2" => profile121,
      "v1.2.1" => profile121,
      "v1.2.0" => profile120,
      "v1.2.0 ep v3.00" => eportal_v3,
      "v1.2.0 jp v1.0" => japan_profile120_v10,
      "v1.2.0 jp v1.1" => japan_profile120_v11,
      "v1.2.1 jp v1.1" => japan_profile121_v11
    }.freeze

    def self.use(profile_name, &block)
      Meibo.with_profile(self[profile_name], &block)
    end

    def self.[](profile_name)
      PROFILES.fetch(profile_name)
    end
  end
end
