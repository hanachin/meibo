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
        academic_sessions: Meibo::AcademicSessionSet,
        classes: Meibo::ClassroomSet,
        courses: Meibo::CourseSet,
        demographics: Meibo::DemographicSet,
        enrollments: Meibo::EnrollmentSet,
        orgs: Meibo::OrganizationSet,
        roles: Meibo::RoleSet,
        user_profiles: Meibo::UserProfileSet,
        users: Meibo::UserSet
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
      builders: profile121.builders.merge(
        academic_session: Builder::AcademicSessionBuilder.create(JapanProfile::AcademicSession),
        class: Builder::ClassroomBuilder.create(JapanProfile::Classroom),
        course: Builder::CourseBuilder.create(JapanProfile::Course),
        demographic: Builder::DemographicBuilder.create(JapanProfile::Demographic),
        enrollment: Builder::EnrollmentBuilder.create(JapanProfile::Enrollment),
        org: Builder::OrganizationBuilder.create(JapanProfile::Organization),
        user: Builder::UserBuilder.create(JapanProfile::User)
      ),
      data_models: profile121.data_models.merge(
        file_academic_sessions: JapanProfile::AcademicSession,
        file_classes: JapanProfile::Classroom,
        file_courses: JapanProfile::Course,
        file_demographics: JapanProfile::Demographic,
        file_enrollments: JapanProfile::Enrollment,
        file_orgs: JapanProfile::Organization,
        file_users: JapanProfile::User
      ),
      data_set: profile121.data_set.merge(
        users: JapanProfile::UserSet
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

    PROFILES = {
      "v1.2" => profile121,
      "v1.2.1" => profile121,
      "v1.2.0" => profile120,
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
