# frozen_string_literal: true

require 'forwardable'

module Meibo
  class Builder
    extend Forwardable

    attr_reader :package

    def_delegators :@package, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :users, :user_profiles

    def initialize(package:)
      @package = package
    end

    def build_organization(**kw)
      OrganizationBuilder.new(builder: self, **kw)
    end

    def build_academic_session(**kw)
      AcademicSessionBuilder.new(builder: self, **kw)
    end
  end
end
