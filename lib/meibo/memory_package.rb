# frozen_string_literal: true

require 'zip'
require 'csv'

module Meibo
  class MemoryPackage
    attr_reader :manifest_properties, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :user_profiles, :users

    def initialize(manifest_properties: {}, academic_sessions: [], classes: [], courses: [], demographics: [], enrollments: [], organizations: [], roles: [], user_profiles: [], users: [])
      @manifest_properties = manifest_properties
      @academic_sessions = academic_sessions
      @classes = classes
      @courses = courses
      @demographics = demographics
      @enrollments = enrollments
      @organizations = organizations
      @roles = roles
      @user_profiles = user_profiles
      @users = users
    end

    def write(path)
      Zip::File.open(path, ::Zip::File::CREATE) do |zipfile|
        manifest = build_manifest
        zipfile.get_output_stream(::Meibo::Manifest.filename) do |f|
          f.puts ::Meibo::Manifest.header_fields.to_csv
          manifest.to_a.each do |row|
            f.puts row.to_csv
          end
        end
        [
          [::Meibo::AcademicSession, academic_sessions],
          [::Meibo::Classroom, classes],
          [::Meibo::Course, courses],
          [::Meibo::Demographic, demographics],
          [::Meibo::Enrollment, enrollments],
          [::Meibo::Organization, organizations],
          [::Meibo::Role, roles],
          [::Meibo::UserProfile, user_profiles],
          [::Meibo::User, users]
        ].each do |klass, data|
          next if data.empty?

          zipfile.get_output_stream(klass.filename) do |f|
            f.puts klass.header_fields.to_csv
            data.each do |row|
              f.puts row.to_csv(write_converters: klass.write_converters)
            end
          end
        end
      end
    end

    private

    def csv_file_type(data)
      if data.empty?
        Meibo::Manifest::FILE_TYPE[:absent]
      else
        Meibo::Manifest::FILE_TYPE[:bulk]
      end
    end

    def build_manifest
      manifest_properties = {
        file_academic_sessions: csv_file_type(academic_sessions),
        file_classes: csv_file_type(classes),
        file_courses: csv_file_type(courses),
        file_demographics: csv_file_type(demographics),
        file_enrollments: csv_file_type(enrollments),
        file_orgs: csv_file_type(organizations),
        file_roles: csv_file_type(roles),
        file_user_profiles: csv_file_type(user_profiles),
        file_users: csv_file_type(users)
      }.merge(self.manifest_properties)
      Meibo::Manifest.build_from_default(**manifest_properties)
    end
  end
end
