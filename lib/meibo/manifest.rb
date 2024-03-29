# frozen_string_literal: true

module Meibo
  class Manifest
    MANIFEST_VERSION = "1.0"
    ONEROSTER_VERSION = "1.2"

    PROPERTY_NAME_TO_ATTRIBUTE_MAP = {
      "manifest.version" => :manifest_version,
      "oneroster.version" => :oneroster_version,
      "file.academicSessions" => :file_academic_sessions,
      "file.categories" => :file_categories,
      "file.classes" => :file_classes,
      "file.classResources" => :file_class_resources,
      "file.courses" => :file_courses,
      "file.courseResources" => :file_course_resources,
      "file.demographics" => :file_demographics,
      "file.enrollments" => :file_enrollments,
      "file.lineItemLearningObjectiveIds" => :file_line_item_learning_objective_ids,
      "file.lineItems" => :file_line_items,
      "file.lineItemScoreScales" => :file_line_item_score_scales,
      "file.orgs" => :file_orgs,
      "file.resources" => :file_resources,
      "file.resultLearningObjectiveIds" => :file_result_learning_objective_ids,
      "file.results" => :file_results,
      "file.resultScoreScales" => :file_result_score_scales,
      "file.roles" => :file_roles,
      "file.scoreScales" => :file_score_scales,
      "file.userProfiles" => :file_user_profiles,
      "file.userResources" => :file_user_resources,
      "file.users" => :file_users,
      "source.systemName" => :source_system_name,
      "source.systemCode" => :source_system_code
    }.freeze
    ATTRIBUTE_TO_PROPERTY_NAME_MAP = PROPERTY_NAME_TO_ATTRIBUTE_MAP.to_h do |property_name, attribute|
      [attribute, property_name]
    end.freeze

    attr_reader :manifest_version, :oneroster_version, :source_system_name, :source_system_code, :file_academic_sessions,
                :file_categories, :file_classes, :file_class_resources, :file_courses, :file_course_resources,
                :file_demographics, :file_enrollments, :file_line_item_learning_objective_ids, :file_line_items, :file_line_item_score_scales,
                :file_orgs, :file_resources, :file_result_learning_objective_ids, :file_results, :file_result_score_scales,
                :file_roles, :file_score_scales, :file_user_profiles, :file_user_resources, :file_users

    def self.filename
      "manifest.csv"
    end

    attribute_names_to_header_fields = {
      property_name: "propertyName",
      value: "value"
    }.freeze
    attribute_names = attribute_names_to_header_fields.keys.freeze
    header_converters = Converter.build_header_field_to_attribute_converter(attribute_names_to_header_fields)
    header_fields = attribute_names_to_header_fields.values.freeze
    define_singleton_method(:attribute_names_to_header_fields) { attribute_names_to_header_fields }
    define_singleton_method(:attribute_names) { attribute_names }
    define_singleton_method(:header_converters) { header_converters }
    define_singleton_method(:header_fields) { header_fields }

    def self.attribute_to_property_name(attribute)
      ATTRIBUTE_TO_PROPERTY_NAME_MAP.fetch(attribute)
    end

    def self.filename_for(attribute)
      property_name = attribute_to_property_name(attribute)

      raise Meibo::Error, "#{property_name}はファイルのプロパティではありません" unless property_name.start_with?("file.")

      "#{property_name.split("file.", 2).last}.csv"
    end

    def self.parse(csv)
      properties = CSV.parse(csv, encoding: Meibo::CSV_ENCODING, headers: true, header_converters: header_converters)
      new(**properties.to_h do |property|
              [PROPERTY_NAME_TO_ATTRIBUTE_MAP.fetch(property[:property_name]), property[:value]]
            end)
    end

    def initialize(
      file_academic_sessions: ProcessingMode.absent,
      file_categories: ProcessingMode.absent,
      file_classes: ProcessingMode.absent,
      file_class_resources: ProcessingMode.absent,
      file_courses: ProcessingMode.absent,
      file_course_resources: ProcessingMode.absent,
      file_demographics: ProcessingMode.absent,
      file_enrollments: ProcessingMode.absent,
      file_line_item_learning_objective_ids: ProcessingMode.absent,
      file_line_items: ProcessingMode.absent,
      file_line_item_score_scales: ProcessingMode.absent,
      file_orgs: ProcessingMode.absent,
      file_resources: ProcessingMode.absent,
      file_result_learning_objective_ids: ProcessingMode.absent,
      file_results: ProcessingMode.absent,
      file_result_score_scales: ProcessingMode.absent,
      file_roles: ProcessingMode.absent,
      file_score_scales: ProcessingMode.absent,
      file_user_profiles: ProcessingMode.absent,
      file_user_resources: ProcessingMode.absent,
      file_users: ProcessingMode.absent,
      manifest_version: MANIFEST_VERSION,
      oneroster_version: ONEROSTER_VERSION,
      source_system_name: nil,
      source_system_code: nil
    )
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

    def filenames(processing_mode:)
      file_attributes(processing_mode: processing_mode).map do |attribute|
        self.class.filename_for(attribute)
      end
    end

    def file_attributes(processing_mode:)
      PROPERTY_NAME_TO_ATTRIBUTE_MAP.values.filter_map do |attribute|
        attribute.start_with?("file_") && public_send(attribute) == processing_mode.to_s && attribute
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
      PROPERTY_NAME_TO_ATTRIBUTE_MAP.values.to_h { |attribute| [attribute, public_send(attribute)] }
    end
  end
end
