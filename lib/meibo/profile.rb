# frozen_string_literal: true

module Meibo
  class Profile
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
    }

    DATA_MODELS = {
      file_academic_sessions: Meibo::AcademicSession,
      file_classes: Meibo::Classroom,
      file_courses: Meibo::Course,
      file_demographics: Meibo::Demographic,
      file_enrollments: Meibo::Enrollment,
      file_orgs: Meibo::Organization,
      file_roles: Meibo::Role,
      file_user_profiles: Meibo::UserProfile,
      file_users: Meibo::User
    }

    DATA_SET = {
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

    attr_reader :builders, :data_models, :data_set

    def initialize(builders: BUILDERS, data_models: DATA_MODELS, data_set: DATA_SET)
      @builders = builders
      @data_models = data_models
      @data_set = data_set
    end

    def builder_for(key)
      builders[key]
    end

    def data_model_for(file_attribute)
      data_models[file_attribute]
    end

    def data_set_for(name)
      data_set[name]
    end
  end
end
