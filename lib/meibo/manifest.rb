# frozen_string_literal: true

module Meibo
  class Manifest
    CSV_FILE_TYPE = {
      absent: 'absent',
      bulk: 'bulk',
      delta: 'delta'
    }.freeze

    PROPERTY_NAME_TO_ATTRIBUTE_MAP = {
      'manifest.version' => :manifest_version,
      'oneroster.version' => :oneroster_version,
      'file.academicSessions' => :file_academic_sessions,
      'file.categories' => :file_categories,
      'file.classes' => :file_classes,
      'file.classResources' => :file_class_resources,
      'file.courses' => :file_courses,
      'file.courseResources' => :file_course_resources,
      'file.demographics' => :file_demographics,
      'file.enrollments' => :file_enrollments,
      'file.lineItemLearningObjectiveIds' => :file_line_item_learning_objective_ids,
      'file.lineItems' => :file_line_items,
      'file.lineItemScoreScales' => :file_line_item_score_scales,
      'file.orgs' => :file_orgs,
      'file.resources' => :file_resources,
      'file.resultLearningObjectiveIds' => :file_result_learning_objective_ids,
      'file.results' => :file_results,
      'file.resultScoreScales' => :file_result_score_scales,
      'file.roles' => :file_roles,
      'file.scoreScales' => :file_score_scales,
      'file.userProfiles' => :file_user_profiles,
      'file.userResources' => :file_user_resources,
      'file.users' => :file_users,
      'source.systemName' => :source_system_name,
      'source.systemCode' => :source_system_code
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

    def self.filename
      'manifest.csv'
    end

    attribute_name_to_header_field_map = {
      property_name: 'propertyName',
      value: 'value'
    }
    header_fields = attribute_name_to_header_field_map.values
    define_singleton_method(:header_fields) { header_fields }
    DataModel.define_header_converters(self, attribute_name_to_header_field_map)

    def self.parse(csv)
      properties = CSV.parse(csv, encoding: Meibo::CSV_ENCODING, headers: true, header_converters: header_converters)
      new(**properties.to_h {|property| [PROPERTY_NAME_TO_ATTRIBUTE_MAP.fetch(property[:property_name]), property[:value]] })
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

    def delta_file_attributes
      PROPERTY_NAME_TO_ATTRIBUTE_MAP.values.filter_map do |attribute|
        attribute.start_with?('file_') && public_send(attribute) == CSV_FILE_TYPE[:delta] && attribute
      end
    end

    def deconstruct
      to_a
    end

    def deconstruct_keys(_keys)
      to_h
    end

    def to_a
      PROPERTY_NAME_TO_ATTRIBUTE_MAP.map do |property_name, attribute|
        [property_name, public_send(attribute)]
      end
    end

    def to_h
      PROPERTY_NAME_TO_ATTRIBUTE_MAP.values.to_h {|attribute| [attribute, public_send(attribute)] }
    end
  end
end
