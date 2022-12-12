# frozen_string_literal: true

require "zip"
require "csv"

module Meibo
  class Roster
    class << self
      def from_file(file_path, profile: Meibo.default_profile)
        Reader.open(file_path, profile: profile) do |reader|
          return read_data(reader, profile)
        end
      end

      def from_buffer(io, profile: Meibo.default_profile)
        Reader.open_buffer(io, profile: profile) do |reader|
          return read_data(reader, profile)
        end
      end

      def open(io_or_path, **opts)
        m = io_or_path.kind_of?(IO) ? :from_buffer : :from_file
        roster = public_send(m, io_or_path, **opts)
        return roster unless block_given?

        Meibo.with_roster(roster) { yield roster }
      end

      private

      def read_data(reader, profile)
        begin
          manifest = reader.manifest
        rescue CsvFileNotFoundError
          raise NotSupportedError, "OneRoster 1.0\u306F\u30B5\u30DD\u30FC\u30C8\u3057\u3066\u3044\u307E\u305B\u3093"
        rescue StandardError
          raise NotSupportedError, "#{Meibo::Manifest.filename}の読み込みに失敗しました"
        end

        validate_manifest_version(manifest.manifest_version)
        validate_oneroster_version(manifest.oneroster_version)
        validate_supported_processing_mode(manifest)
        processing_modes = Meibo::Manifest::PROCESSING_MODES
        validate_absent_files(reader, manifest.filenames(processing_mode: processing_modes[:absent]))
        validate_bulk_files(reader, manifest.filenames(processing_mode: processing_modes[:bulk]))

        new(manifest_properties: manifest.to_h, profile: profile,
            **reader.load_bulk_files).tap(&:check_semantically_consistent)
      end

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

        raise NotSupportedError, "DELTA\u306F\u30B5\u30DD\u30FC\u30C8\u3057\u3066\u3044\u307E\u305B\u3093"
      end
    end

    attr_reader :profile, :manifest_properties, :academic_sessions, :classes, :courses, :demographics, :enrollments,
                :organizations, :roles, :user_profiles, :users

    def initialize(profile: Meibo.default_profile, manifest_properties: {}, academic_sessions: [], classes: [],
                   courses: [], demographics: [], enrollments: [], organizations: [], roles: [], user_profiles: [], users: [])
      @profile = profile
      @manifest_properties = manifest_properties
      @academic_sessions = profile.data_set_for(:academic_sessions).new(academic_sessions, roster: self)
      @classes = profile.data_set_for(:classes).new(classes, roster: self)
      @courses = profile.data_set_for(:courses).new(courses, roster: self)
      @demographics = profile.data_set_for(:demographics).new(demographics, roster: self)
      @enrollments = profile.data_set_for(:enrollments).new(enrollments, roster: self)
      @organizations = profile.data_set_for(:orgs).new(organizations, roster: self)
      @roles = profile.data_set_for(:roles).new(roles, roster: self)
      @user_profiles = profile.data_set_for(:user_profiles).new(user_profiles, roster: self)
      @users = profile.data_set_for(:users).new(users, roster: self)
    end

    def builder
      Builder.new(roster: self, profile: profile)
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

    def write_to_buffer(io)
      Zip::File.open_buffer(io) do |zipfile|
        write(zipfile)
      end
    end

    def write_to_file(path)
      Zip::File.open(path, Zip::File::CREATE) do |zipfile|
        write(zipfile)
      end
    end

    private

    def write(zipfile)
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
