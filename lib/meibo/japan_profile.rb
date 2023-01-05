# frozen_string_literal: true

module Meibo
  class JapanProfile < ::Meibo::Profile
    # @type var builders: ::Meibo::Profile::builders_type
    builders = {
      academic_session: Builder::AcademicSessionBuilder.create(AcademicSession),
      class: Builder::ClassroomBuilder.create(Classroom),
      course: Builder::CourseBuilder.create(Course),
      demographic: Builder::DemographicBuilder.create(Demographic),
      enrollment: Builder::EnrollmentBuilder.create(Enrollment),
      org: Builder::OrganizationBuilder.create(Organization),
      role: Builder::RoleBuilder.create(Role),
      user: Builder::UserBuilder.create(User),
      user_profile: Builder::UserProfileBuilder.create(UserProfile)
    }
    builders.freeze
    BUILDERS = builders

    # @type var data_models: ::Meibo::Profile::data_models_type
    data_models = {
      file_academic_sessions: AcademicSession,
      file_classes: Classroom,
      file_courses: Course,
      file_demographics: Demographic,
      file_enrollments: Enrollment,
      file_orgs: Organization,
      file_roles: Role,
      file_user_profiles: UserProfile,
      file_users: User
    }
    data_models.freeze
    DATA_MODELS = data_models

    # @type var data_set: ::Meibo::Profile::data_set_type
    data_set = ::Meibo::Profile::DATA_SET.dup
    data_set[:users] = UserSet
    data_set.freeze
    DATA_SET = data_set

    def initialize(builders: BUILDERS, data_models: DATA_MODELS, data_set: DATA_SET)
      super
    end
  end
end
