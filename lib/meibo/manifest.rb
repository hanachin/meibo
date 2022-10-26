# frozen_string_literal: true

module Meibo
  class Manifest
    FILENAME = 'manifest.csv'

    CSV_FILE_TYPE = {
      absent: 'absent',
      bulk: 'bulk',
      delta: 'delta'
    }.freeze
    HEADER_FIELDS = ['propertyName', 'value'].freeze
    PROPERTY_NAMES = {
      manifest_version: 'manifest.version',
      oneroster_version: 'oneroster.version',
      file_academic_sessions: 'file.academicSessions',
      file_categories: 'file.categories',
      file_classes: 'file.classes',
      file_class_resources: 'file.classResources',
      file_courses: 'file.courses',
      file_course_resources: 'file.courseResources',
      file_demographics: 'file.demographics',
      file_enrollments: 'file.enrollments',
      file_line_item_learning_objective_ids: 'file.lineItemLearningObjectiveIds',
      file_line_items: 'file.lineItems',
      file_line_item_score_scales: 'file.lineItemScoreScales',
      file_orgs: 'file.orgs',
      file_resources: 'file.resources',
      file_result_learning_objective_ids: 'file.resultLearningObjectiveIds',
      file_results: 'file.results',
      file_result_score_scales: 'file.resultScoreScales',
      file_roles: 'file.roles',
      file_score_scales: 'file.scoreScales',
      file_user_profiles: 'file.userProfiles',
      file_user_resources: 'file.userResources',
      file_users: 'file.users',
      source_system_name: 'source.systemName',
      source_system_code: 'source.systemCode'
    }.freeze

    # NOTE: 想定値
    DEFAULT_VALUES = {
      manifest_version: '1.0',
      oneroster_version: '1.2',
      file_academic_sessions: CSV_FILE_TYPE[:bulk],
      file_categories: CSV_FILE_TYPE[:absent],
      file_classes: CSV_FILE_TYPE[:bulk],
      file_class_resources: CSV_FILE_TYPE[:absent],
      file_courses: CSV_FILE_TYPE[:bulk],
      file_course_resources: CSV_FILE_TYPE[:absent],
      file_demographics: CSV_FILE_TYPE[:bulk],
      file_enrollments: CSV_FILE_TYPE[:bulk],
      file_line_item_learning_objective_ids: CSV_FILE_TYPE[:absent],
      file_line_items: CSV_FILE_TYPE[:absent],
      file_line_item_score_scales: CSV_FILE_TYPE[:absent],
      file_orgs: CSV_FILE_TYPE[:bulk],
      file_resources: CSV_FILE_TYPE[:absent],
      file_result_learning_objective_ids: CSV_FILE_TYPE[:absent],
      file_results: CSV_FILE_TYPE[:absent],
      file_result_score_scales: CSV_FILE_TYPE[:absent],
      file_roles: CSV_FILE_TYPE[:bulk],
      file_score_scales: CSV_FILE_TYPE[:absent],
      file_user_profiles: CSV_FILE_TYPE[:bulk],
      file_user_resources: CSV_FILE_TYPE[:absent],
      file_users: CSV_FILE_TYPE[:bulk]
    }.freeze

    attr_reader :manifest_version, :oneroster_version, :file_academic_sessions, :file_categories, :file_classes, :file_class_resources, :file_courses, :file_course_resources, :file_demographics, :file_enrollments, :file_line_item_learning_objective_ids, :file_line_items, :file_line_item_score_scales, :file_orgs, :file_resources, :file_result_learning_objective_ids, :file_results, :file_result_score_scales, :file_roles, :file_score_scales, :file_user_profiles, :file_user_resources, :file_users, :source_system_name, :source_system_code

    def self.build_from_default(**custom_properties)
      new(**Manifest::DEFAULT_VALUES.merge(custom_properties))
    end

    def initialize(manifest_version:, oneroster_version:, file_academic_sessions:, file_categories:, file_classes:, file_class_resources:, file_courses:, file_course_resources:, file_demographics:, file_enrollments:, file_line_item_learning_objective_ids:, file_line_items:, file_line_item_score_scales:, file_orgs:, file_resources:, file_result_learning_objective_ids:, file_results:, file_result_score_scales:, file_roles:, file_score_scales:, file_user_profiles:, file_user_resources:, file_users:, source_system_name: nil, source_system_code: nil)
      @manifest_version = manifest_version
      @oneroster_version = oneroster_version
      @file_academic_sessions = file_academic_sessions
      @file_categories = file_categories
      @file_classes = file_classes
      @file_class_resources = file_class_resources
      @file_courses = file_courses
      @file_course_resources = file_course_resources
      @file_demographics = file_demographics
      @file_enrollments = file_enrollments
      @file_line_item_learning_objective_ids = file_line_item_learning_objective_ids
      @file_line_items = file_line_items
      @file_line_item_score_scales = file_line_item_score_scales
      @file_orgs = file_orgs
      @file_resources = file_resources
      @file_result_learning_objective_ids = file_result_learning_objective_ids
      @file_results = file_results
      @file_result_score_scales = file_result_score_scales
      @file_roles = file_roles
      @file_score_scales = file_score_scales
      @file_user_profiles = file_user_profiles
      @file_user_resources = file_user_resources
      @file_users = file_users
      @source_system_name = source_system_name
      @source_system_code = source_system_code
    end

    def rows
      data = [HEADER_FIELDS]
      PROPERTY_NAMES.each do |key, property_name|
        value = public_send(key)
        data << [property_name, value]
      end
      data
    end
  end
end
