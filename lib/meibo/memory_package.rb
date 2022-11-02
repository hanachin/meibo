# frozen_string_literal: true

require 'zip'
require 'csv'

module Meibo
  class MemoryPackage
    attr_reader :profile, :manifest_properties, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :user_profiles, :users

    def initialize(profile: BaseProfile, manifest_properties: {}, academic_sessions: [], classes: [], courses: [], demographics: [], enrollments: [], organizations: [], roles: [], user_profiles: [], users: [])
      @profile = profile
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
        file_properties.each do |file_attribute, processing_mode|
          next if processing_mode.absent?

          klass = profile.data_model_for(file_attribute)
          filename = profile.filename_for(file_attribute)
          data = data_for(file_attribute)
          zipfile.get_output_stream(filename) do |f|
            f.puts klass.header_fields.to_csv
            data.each do |row|
              f.puts row.to_csv(write_converters: klass.write_converters)
            end
          end
        end
      end
    end

    private

    def build_manifest
      new_manifest_properties = file_properties.merge(manifest_properties)
      Meibo::Manifest.build_from_default(**new_manifest_properties)
    end

    def data_for(file_attribute)
      data_method = {
        file_academic_sessions: :academic_sessions,
        file_classes: :classes,
        file_courses: :courses,
        file_demographics: :demographics,
        file_enrollments: :enrollments,
        file_orgs: :organizations,
        file_roles: :roles,
        file_user_profiles: :user_profiles,
        file_users: :users
      }[file_attribute]
      public_send(data_method)
    end

    def file_properties
      {
        file_academic_sessions: procesing_mode(academic_sessions),
        file_classes: procesing_mode(classes),
        file_courses: procesing_mode(courses),
        file_demographics: procesing_mode(demographics),
        file_enrollments: procesing_mode(enrollments),
        file_orgs: procesing_mode(organizations),
        file_roles: procesing_mode(roles),
        file_user_profiles: procesing_mode(user_profiles),
        file_users: procesing_mode(users)
      }
    end

    def procesing_mode(data)
      if data.empty?
        Meibo::Manifest::PROCESSING_MODES[:absent]
      else
        Meibo::Manifest::PROCESSING_MODES[:bulk]
      end
    end
  end
end
