# frozen_string_literal: true

require 'forwardable'

module Meibo
  class Builder
    extend Forwardable

    BUILDERS = {
      academic_session: AcademicSessionBuilder.create(AcademicSession),
      classroom: ClassroomBuilder.create(Classroom),
      course: CourseBuilder.create(Course),
      demographic: DemographicBuilder.create(Demographic),
      enrollment: EnrollmentBuilder.create(Enrollment),
      organization: OrganizationBuilder.create(Organization),
      role: RoleBuilder.create(Role),
      user: UserBuilder.create(User),
      user_profile: UserProfileBuilder.create(UserProfile)
    }

    attr_reader :package

    def_delegators :@package, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :users, :user_profiles

    def initialize(package:)
      @package = package
    end

    def build_academic_session(**kw)
      builder_for(:academic_session).new(builder: self, **kw)
    end

    def build_classroom(**kw)
      builder_for(:classroom).new(builder: self, **kw)
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
      builder_for(:organization).new(builder: self, **kw)
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
      BUILDERS[key]
    end
  end
end
