# frozen_string_literal: true

module Meibo
  class Profile
    attr_reader :builders, :data_models, :data_set, :manifest_properties, :allow_duplicate_user_master_identifiers

    def initialize(builders:, data_models:, data_set:, manifest_properties: {}, allow_duplicate_user_master_identifiers: true)
      @builders = builders
      @data_models = data_models
      @data_set = data_set
      @manifest_properties = manifest_properties
      @allow_duplicate_user_master_identifiers = allow_duplicate_user_master_identifiers
    end

    def builder_for(key)
      builders[key]
    end

    def data_model_for(file_attribute)
      data_models[file_attribute]
    end

    def data_set_for(file_attribute)
      data_set[file_attribute]
    end

    def manifest_version = manifest_properties.fetch(:manifest_version, Meibo::Manifest::MANIFEST_VERSION)
    def oneroster_version = manifest_properties.fetch(:oneroster_version, Meibo::Manifest::ONEROSTER_VERSION)
  end
end
