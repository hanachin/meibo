# frozen_string_literal: true

require 'csv'
require 'zip'

module Meibo
  class Reader
    def self.open(file_path)
      Zip::File.open(file_path) do |zipfile|
        yield new(zipfile: zipfile)
      end
    end

    attr_reader :zipfile

    def initialize(zipfile:)
      @zipfile = zipfile
    end

    def academic_sessions
      each_academic_session.to_a
    end

    def classes
      each_class.to_a
    end

    def courses
      each_course.to_a
    end

    def demographics
      each_demographic.to_a
    end

    def enrollments
      each_enrollment.to_a
    end

    def organizations
      each_organization.to_a
    end

    def roles
      each_role.to_a
    end

    def users
      each_user.to_a
    end

    def user_profiles
      each_user_profile.to_a
    end

    def each_academic_session(data_class: Meibo::AcademicSession, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_class(data_class: Meibo::Classroom, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_course(data_class: Meibo::Course, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_demographic(data_class: Meibo::Demographic, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_enrollment(data_class: Meibo::Enrollment, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_organization(data_class: Meibo::Organization, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_role(data_class: Meibo::Role, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_user_profile(data_class: Meibo::UserProfile, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def each_user(data_class: Meibo::User, &block)
      data_class.parse(read_csv(data_class.filename), &block)
    end

    def manifest
      @manifest ||= Meibo::Manifest.parse(read_csv(Meibo::Manifest.filename))
    end

    def load_bulk_files
      bulk_file_attributes = manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:bulk])
      {
        file_academic_sessions: :academic_sessions,
        file_classes: :classes,
        file_courses: :courses,
        file_demographics: :demographics,
        file_enrollments: :enrollments,
        file_orgs: :organizations,
        file_roles: :roles,
        file_users: :users,
        file_user_profiles: :user_profiles
      }.filter_map {|file_attribute, data_method|
        if bulk_file_attributes.include?(file_attribute)
          [data_method, public_send(data_method).to_a]
        end
      }.to_h
    end

    def file_entry?(filename)
      @zipfile.get_entry(filename).file?
    rescue Errno::ENOENT
      false
    end

    private

    def read_csv(filename)
      raise CsvFileNotFoundError, "#{filename} not found" unless file_entry?(filename)

      @zipfile.read(filename)
    end
  end
end
