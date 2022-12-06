# frozen_string_literal: true

module Meibo
  class JapanProfile < ::Meibo::Profile
    BUILDERS = {
      academic_session: Builder::AcademicSessionBuilder.create(AcademicSession),
      class: Builder::ClassroomBuilder.create(Classroom),
      course: Builder::CourseBuilder.create(Course),
      demographic: Builder::DemographicBuilder.create(Demographic),
      enrollment: Builder::EnrollmentBuilder.create(Enrollment),
      org: Builder::OrganizationBuilder.create(Organization),
      role: Builder::RoleBuilder.create(Role),
      user: Builder::UserBuilder.create(User),
      user_profile: Builder::UserProfileBuilder.create(UserProfile)
    }.freeze

    DATA_MODELS = {
      file_academic_sessions: AcademicSession,
      file_classes: Classroom,
      file_courses: Course,
      file_demographics: Demographic,
      file_enrollments: Enrollment,
      file_orgs: Organization,
      file_roles: Role,
      file_user_profiles: UserProfile,
      file_users: User
    }.freeze

    DATA_SET = ::Meibo::Profile::DATA_SET.merge(
      users: UserSet
    )

    def initialize(builders: BUILDERS, data_models: DATA_MODELS, data_set: DATA_SET)
      super
    end
  end
end
