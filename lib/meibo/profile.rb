# frozen_string_literal: true

module Meibo
  class Profile
    attr_reader :builders, :data_models, :data_set

    def initialize(builders:, data_models:, data_set:)
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
