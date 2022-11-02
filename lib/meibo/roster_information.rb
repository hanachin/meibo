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

          new(**reader.load_bulk_files).tap(&:check_semantically_consistent)
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

    attr_reader :academic_sessions, :classes, :courses, :demographics, :enrollments, :organizations, :roles, :user_profiles, :users

    def initialize(academic_sessions: [], classes: [], courses: [], demographics: [], enrollments: [], organizations: [], roles: [], user_profiles: [], users: [])
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
  end
end
