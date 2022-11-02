# frozen_string_literal: true

require 'forwardable'

module Meibo
  class Builder
    extend Forwardable

    attr_reader :package, :profile

    def_delegators :@package, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :users, :user_profiles

    def initialize(package:, profile: BaseProfile)
      @package = package
      @profile = profile
    end

    def build_academic_session(**kw)
      builder_for(:academic_session).new(builder: self, **kw)
    end

    def build_classroom(**kw)
      builder_for(:class).new(builder: self, **kw)
    end

    def build_course(**kw)
      builder_for(:course).new(builder: self, **kw)
    end

    def build_demographic(**kw)
      builder_for(:demographic).new(builder: self, **kw)
    end

    def build_enrollment(**kw)
      builder_for(:enrollment).new(builder: self, **kw)
    end

    def build_organization(**kw)
      builder_for(:org).new(builder: self, **kw)
    end

    def build_role(**kw)
      builder_for(:role).new(builder: self, **kw)
    end

    def build_user(**kw)
      builder_for(:user).new(builder: self, **kw)
    end

    def build_user_profile(**kw)
      builder_for(:user_profile).new(builder: self, **kw)
    end

    private

    def builder_for(key)
      profile.builder_for(key)
    end
  end
end
