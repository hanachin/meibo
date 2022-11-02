# frozen_string_literal: true

require 'zip'
require 'csv'

module Meibo
  class RosterInformation
    class << self
      def from_file(file_path, profile: BaseProfile)
        Reader.open(file_path, profile: profile) do |reader|
          begin
            manifest = reader.manifest
          rescue CsvFileNotFoundError
            raise NotSupportedError, 'OneRoster 1.0はサポートしていません'
          rescue
            raise NotSupportedError, "#{Meibo::Manifest.filename}の読み込みに失敗しました"
          end

          validate_manifest_version(manifest.manifest_version)
          validate_oneroster_version(manifest.oneroster_version)
          validate_supported_processing_mode(manifest)
          processing_modes = Meibo::Manifest::PROCESSING_MODES
          validate_absent_files(reader, manifest.filenames(processing_mode: processing_modes[:absent]))
          validate_bulk_files(reader, manifest.filenames(processing_mode: processing_modes[:bulk]))

          new(manifest_properties: manifest.to_h, profile: profile, **reader.load_bulk_files).tap(&:check_semantically_consistent)
        end
      end

      private

      def validate_absent_files(reader, absent_filenames)
        absent_filenames.each do |absent_filename|
          next unless reader.file_entry?(absent_filename)

          raise NotSupportedError, "#{absent_filename}が存在します"
        end
      end

      def validate_bulk_files(reader, bulk_filenames)
        bulk_filenames.each do |bulk_filename|
          next if reader.file_entry?(bulk_filename)

          raise NotSupportedError, "#{bulk_filename}が存在しません"
        end
      end

      def validate_manifest_version(manifest_version)
        return if manifest_version == Meibo::Manifest::MANIFEST_VERSION

        raise NotSupportedError, "manifest.version: #{manifest_version}はサポートしていません"
      end

      def validate_oneroster_version(oneroster_version)
        return if oneroster_version == Meibo::Manifest::ONEROSTER_VERSION

        raise NotSupportedError, "oneroster.version: #{oneroster_version}はサポートしていません"
      end

      def validate_supported_processing_mode(manifest)
        return if manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:delta]).empty?

        raise NotSupportedError, 'DELTAはサポートしていません'
      end
    end

    attr_reader :profile, :manifest_properties, :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :user_profiles, :users

    def initialize(profile: BaseProfile, manifest_properties: {}, academic_sessions: [], classes: [], courses: [], demographics: [], enrollments: [], organizations: [], roles: [], user_profiles: [], users: [])
      @profile = profile
      @manifest_properties = manifest_properties
      @academic_sessions = AcademicSessionSet.new(academic_sessions)
      @organizations = OrganizationSet.new(organizations)
      @courses = CourseSet.new(courses, academic_session_set: @academic_sessions, organization_set: @organizations)
      @classes = ClassroomSet.new(classes, academic_session_set: @academic_sessions, course_set: @courses, organization_set: @organizations)
      @users = UserSet.new(users, organization_set: @organizations)
      @demographics = DemographicSet.new(demographics, user_set: @users)
      @user_profiles = UserProfileSet.new(user_profiles, user_set: @users)
      @roles = RoleSet.new(roles, organization_set: @organizations, user_set: @users, user_profile_set: @user_profiles)
      @enrollments = EnrollmentSet.new(enrollments, classroom_set: @classes, organization_set: @organizations, user_set: @users)
    end

    def check_semantically_consistent
      [
        academic_sessions,
        classes,
        courses,
        demographics,
        enrollments,
        organizations,
        roles,
        user_profiles,
        users
      ].each(&:check_semantically_consistent)
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
          filename = Manifest.filename_for(file_attribute)
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
