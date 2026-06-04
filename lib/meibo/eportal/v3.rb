# frozen_string_literal: true

module Meibo
  module Eportal::V3
    AcademicSession = ::Meibo::JapanProfile::AcademicSession
    Demographic = ::Meibo::JapanProfile::Demographic
    Role = ::Meibo::JapanProfile::Role

    PROFILE = Profile.new(
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
        file_academic_sessions: AcademicSession,
        file_classes: Classroom,
        file_courses: Course,
        file_demographics: Demographic,
        file_enrollments: Enrollment,
        file_orgs: Organization,
        file_roles: Role,
        file_user_profiles: UserProfile,
        file_users: User
      },
      data_set: {
        file_academic_sessions: AcademicSessionSet,
        file_classes: ClassroomSet,
        file_courses: CourseSet,
        file_demographics: DemographicSet,
        file_enrollments: EnrollmentSet,
        file_orgs: OrganizationSet,
        file_roles: RoleSet,
        file_user_profiles: UserProfileSet,
        file_users: UserSet
      },
      manifest_properties: { oneroster_version: "1.2" }
    )
  end
end
