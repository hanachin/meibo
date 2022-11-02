# frozen_string_literal: true

module Meibo
  module BaseProfile
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

    FILE_ATTRIBUTE_TO_FILENAME = {
      file_academic_sessions: 'academicSessions.csv',
      file_categories: 'categories.csv',
      file_classes: 'classes.csv',
      file_class_resources: 'classResources.csv',
      file_courses: 'courses.csv',
      file_course_resources: 'courseResources.csv',
      file_demographics: 'demographics.csv',
      file_enrollments: 'enrollments.csv',
      file_line_item_learning_objective_ids: 'lineItemLearningObjectiveIds.csv',
      file_line_items: 'lineItems.csv',
      file_line_item_score_scales: 'lineItemScoreScales.csv',
      file_orgs: 'orgs.csv',
      file_resources: 'resources.csv',
      file_result_learning_objective_ids: 'resultLearningObjectiveIds.csv',
      file_results: 'results.csv',
      file_result_score_scales: 'resultScoreScales.csv',
      file_roles: 'roles.csv',
      file_score_scales: 'scoreScales.csv',
      file_user_profiles: 'userProfiles.csv',
      file_user_resources: 'userResources.csv',
      file_users: 'users.csv',
    }.freeze

    def self.builder_for(key)
      BUILDERS[key]
    end

    def self.data_model_for(file_attribute)
      DATA_MODELS[file_attribute]
    end

    def self.filename_for(file_attribute)
      FILE_ATTRIBUTE_TO_FILENAME[file_attribute]
    end
  end
end
