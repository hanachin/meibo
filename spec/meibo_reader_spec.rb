# frozen_string_literal: true

require 'tmpdir'

RSpec.describe Meibo::Reader do
  let(:oneroster_zip_file_path) { Dir.mktmpdir + '/oneroster.zip' }

  before do
    package = Meibo::MemoryPackage.new
    builder = Meibo::JapanProfile::Builder.new(package: package)
    school_year_academic_session = builder.build_academic_session(school_year: 2022)
    organization = builder.build_organization(
      name: '小学校',
      type: Meibo::Organization::TYPES[:school],
      identifier: 'B101200000019'
    )
    course = organization.build_course(
      title: '2022年度',
      school_year: school_year_academic_session
    )
    classroom = course.build_classroom(
      title: '1年1組',
      grades: ['P1'], # TODO: 定数化
      terms: [school_year_academic_session],
      class_type: Meibo::Classroom::TYPES[:homeroom]
    )
    user = organization.build_user(
      username: 'john.doe@example.com',
      given_name: 'John',
      family_name: 'Doe'
    )
    user.build_demographic(sex: Meibo::Demographic::SEX[:male])
    user_profile = user.build_profile(
      profile_type: 'example',
      vendor_id: 'example',
      credential_type: 'example',
      username: 'example'
    )
    role = organization.build_role(
      user: user,
      user_profile: user_profile,
      role: Meibo::Role::ROLES[:student],
      role_type: Meibo::Role::TYPES[:primary]
    )
    classroom.build_enrollment(
      user: user,
      role: Meibo::Enrollment::ROLES[:student]
    )
    package.write(oneroster_zip_file_path)
  end

  after { File.unlink(oneroster_zip_file_path) }

  it "works" do
    Meibo::Reader.open(oneroster_zip_file_path) do |reader|
      reader.manifest => {
        manifest_version: '1.0',
        oneroster_version: '1.2',
        file_academic_sessions: 'bulk',
        file_categories: 'absent',
        file_classes: 'bulk',
        file_class_resources: 'absent',
        file_courses: 'bulk',
        file_course_resources: 'absent',
        file_demographics: 'bulk',
        file_enrollments: 'bulk',
        file_line_item_learning_objective_ids: 'absent',
        file_line_items: 'absent',
        file_line_item_score_scales: 'absent',
        file_orgs: 'bulk',
        file_resources: 'absent',
        file_result_learning_objective_ids: 'absent',
        file_results: 'absent',
        file_result_score_scales: 'absent',
        file_roles: 'bulk',
        file_score_scales: 'absent',
        file_user_profiles: 'bulk',
        file_user_resources: 'absent',
        file_users: 'bulk',
        source_system_name: nil,
        source_system_code: nil
      }

      academic_sessions = *reader.each_academic_session
      start_date = Date.new(2022, 4, 1)
      end_date = Date.new(2023, 3, 31)
      academic_sessions => [
        {
          sourced_id: school_year_sourced_id,
          title: '2022年度',
          type: 'schoolYear',
          start_date: ^start_date,
          end_date: end_date,
          parent_sourced_id: NilClass,
          school_year: 2022
        }
      ]
      organizations = *reader.each_organization
      organizations => [
        {
          sourced_id: org_sourced_id,
          name: '小学校',
          type: 'school',
          identifier: 'B101200000019',
          parent_sourced_id: NilClass
        }
      ]
      courses = *reader.each_course
      courses => [
        {
          sourced_id: course_sourced_id,
          school_year_sourced_id: ^school_year_sourced_id,
          title: '2022年度',
          course_code: '',
          grades: [],
          org_sourced_id: ^org_sourced_id,
          subjects: [],
          subject_codes: []
        }
      ]
      classes = *reader.each_class
      classes => [
        {
          sourced_id: classroom_sourced_id,
          title: '1年1組',
          grades: ['P1'],
          course_sourced_id: ^course_sourced_id,
          class_code: NilClass,
          class_type: 'homeroom',
          location: NilClass,
          school_sourced_id: ^org_sourced_id,
          term_sourced_ids: [^school_year_sourced_id],
          subjects: [],
          subject_codes: [],
          periods: [],
          special_needs: NilClass
        }
      ]
      users = *reader.each_user
      users => [
        {
          sourced_id: user_sourced_id,
          enabled_user: true,
          username: 'john.doe@example.com',
          user_ids: [],
          given_name: 'John',
          family_name: 'Doe',
          middle_name: NilClass,
          identifier: NilClass,
          email: NilClass,
          sms: NilClass,
          phone: NilClass,
          agent_sourced_ids: [],
          grades: [],
          password: NilClass,
          user_master_identifier: NilClass,
          resource_sourced_ids: [],
          preferred_given_name: NilClass,
          preferred_middle_name: NilClass,
          preferred_family_name: NilClass,
          primary_org_sourced_id: org_sourced_id,
          kana_given_name: NilClass,
          kana_family_name: NilClass,
          kana_middle_name: NilClass,
          home_class: NilClass
        }
      ]
      demographics = *reader.each_demographic
      demographics => [
        {
          sourced_id: ^user_sourced_id,
          birth_date: NilClass,
          sex: 'male',
          american_indian_or_alaska_native: NilClass,
          asian: NilClass,
          black_or_african_american: NilClass,
          native_hawaiian_or_other_pacific_islander: NilClass,
          white: NilClass,
          demographic_race_two_or_more_races: NilClass,
          hispanic_or_latino_ethnicity: NilClass,
          country_of_birth_code: NilClass,
          state_of_birth_abbreviation: NilClass,
          city_of_birth: NilClass,
          public_school_residence_status: NilClass
        }
      ]
      user_profiles = *reader.each_user_profile
      user_profiles => [
        {
          sourced_id: user_profile_sourced_id,
          user_sourced_id: ^user_sourced_id,
          profile_type: 'example',
          vendor_id: 'example',
          application_id: nil,
          description: NilClass,
          credential_type: 'example',
          username: 'example',
          password: NilClass
        }
      ]
      roles = *reader.each_role
      roles => [
        {
          sourced_id: String,
          user_sourced_id: ^user_sourced_id,
          role_type: 'primary',
          role: 'student',
          begin_date: NilClass,
          end_date: NilClass,
          org_sourced_id: ^org_sourced_id,
          user_profile_sourced_id: ^user_profile_sourced_id
        }
      ]
      enrollments = *reader.each_enrollment
      enrollments => [
        {
          sourced_id: String,
          class_sourced_id: ^classroom_sourced_id,
          school_sourced_id: ^org_sourced_id,
          user_sourced_id: ^user_sourced_id,
          role: 'student',
          begin_date: NilClass,
          end_date: NilClass,
          shusseki_no: NilClass,
          public_flg: NilClass
        }
      ]
    end
  end
end
