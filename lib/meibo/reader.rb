# frozen_string_literal: true

require "csv"
require "zip"

module Meibo
  class Reader
    def self.open(file_path, profile: Meibo.current_profile)
      Zip::File.open(file_path) do |zipfile|
        yield new(zipfile: zipfile, profile: profile)
      end
    end

    def self.open_buffer(io, profile: Meibo.current_profile)
      Zip::File.open_buffer(io) do |zipfile|
        yield new(zipfile: zipfile, profile: profile)
      end
    end

    attr_reader :profile, :zipfile

    def initialize(zipfile:, profile:)
      @profile = profile
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

    def each_academic_session(&block)
      read_data(:file_academic_sessions, &block)
    end

    def each_class(&block)
      read_data(:file_classes, &block)
    end

    def each_course(&block)
      read_data(:file_courses, &block)
    end

    def each_demographic(&block)
      read_data(:file_demographics, &block)
    end

    def each_enrollment(&block)
      read_data(:file_enrollments, &block)
    end

    def each_organization(&block)
      read_data(:file_orgs, &block)
    end

    def each_role(&block)
      read_data(:file_roles, &block)
    end

    def each_user_profile(&block)
      read_data(:file_user_profiles, &block)
    end

    def each_user(&block)
      read_data(:file_users, &block)
    end

    def manifest
      @manifest ||= begin
        filename = Meibo::Manifest.filename
        raise CsvFileNotFoundError.new("#{filename} not found", filename: filename) unless file_entry?(filename)

        csv = @zipfile.read(filename)
        Meibo::Manifest.parse(csv)
      end
    end

    def load_bulk_files
      bulk_file_attributes = manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:bulk])
      bulk_file_attributes.to_h { |file_attribute| [file_attribute, read_data(file_attribute)&.to_a] }.compact
    end

    def file_entry?(filename)
      @zipfile.get_entry(filename).file?
    rescue Errno::ENOENT
      false
    end

    private

    def read_data(file_attribute, &block)
      filename = Manifest.filename_for(file_attribute)
      raise CsvFileNotFoundError.new("#{filename} not found", filename: filename) unless file_entry?(filename)

      csv = @zipfile.read(filename)
      profile.data_model_for(file_attribute)&.parse(csv, &block)
    end
  end
end
