# frozen_string_literal: true

require 'csv'
require 'zip'

module Meibo
  class Reader
    class CsvFileNotFound < Meibo::Error; end

    def self.open(file_path)
      Zip::File.open(file_path) do |zipfile|
        yield new(zipfile: zipfile)
      end
    end

    attr_reader :zipfile

    def initialize(zipfile:)
      @zipfile = zipfile
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

    private

    def file_entry?(filename)
      @zipfile.get_entry(filename).file?
    rescue Errno::ENOENT
      false
    end

    def read_csv(filename)
      raise CsvFileNotFound, "#{filename} not found" unless file_entry?(filename)

      @zipfile.read(filename)
    end
  end
end
