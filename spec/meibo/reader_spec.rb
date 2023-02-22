# frozen_string_literal: true

RSpec.describe Meibo::Reader do
  let(:roster_io) { StringIO.new }

  before do
    profile = Meibo::Profiles["v1.2.0 jp v1.1"]
    roster = Meibo::Roster.new(profile: profile)
    builder = roster.builder
    school_year_academic_session = builder.build_academic_session(school_year: 2022)
    organization = builder.build_organization(
      name: "\u5C0F\u5B66\u6821",
      type: Meibo::JapanProfile::Organization::TYPES[:school],
      identifier: "B101200000019"
    )
    course = organization.build_course(
      title: "2022\u5E74\u5EA6",
      school_year: school_year_academic_session
    )
    classroom = course.build_classroom(
      title: "1\u5E741\u7D44",
      grades: ["P1"], # TODO: 定数化
      terms: [school_year_academic_session],
      class_type: Meibo::JapanProfile::Classroom::TYPES[:homeroom]
    )
    user = organization.build_user(
      username: "john.doe@example.com",
      given_name: "John",
      family_name: "Doe"
    )
    user.build_demographic(sex: Meibo::JapanProfile::Demographic::SEX[:male])
    user_profile = user.build_profile(
      profile_type: "example",
      vendor_id: "example",
      credential_type: "example",
      username: "example"
    )
    organization.build_role(
      user: user,
      user_profile: user_profile,
      role: Meibo::Role::ROLES[:student],
      role_type: Meibo::Role::TYPES[:primary]
    )
    classroom.build_enrollment(
      user: user,
      role: Meibo::JapanProfile::Enrollment::ROLES[:student]
    )
    roster.write_to_buffer(roster_io)
  end

  it "works good" do
    expect do
      described_class.open_buffer(roster_io, profile: Meibo::Profiles["v1.2.0 jp v1.1"]) do |reader|
        case reader.manifest
        in {
          manifest_version: "1.0",
          oneroster_version: "1.2",
          file_academic_sessions: "bulk",
          file_categories: "absent",
          file_classes: "bulk",
          file_class_resources: "absent",
          file_courses: "bulk",
          file_course_resources: "absent",
          file_demographics: "bulk",
          file_enrollments: "bulk",
          file_line_item_learning_objective_ids: "absent",
          file_line_items: "absent",
          file_line_item_score_scales: "absent",
          file_orgs: "bulk",
          file_resources: "absent",
          file_result_learning_objective_ids: "absent",
          file_results: "absent",
          file_result_score_scales: "absent",
          file_roles: "bulk",
          file_score_scales: "absent",
          file_user_profiles: "bulk",
          file_user_resources: "absent",
          file_users: "bulk",
          source_system_name: nil,
          source_system_code: nil
        }
      end

        academic_sessions = *reader.each_academic_session
        start_date = Date.new(2022, 4, 1)
        end_date = Date.new(2023, 3, 31)
        case academic_sessions
        in [
          {
            sourced_id: school_year_sourced_id,
            title: "2022\u5E74\u5EA6",
            type: "schoolYear",
            start_date: ^start_date,
            end_date: ^end_date,
            parent_sourced_id: NilClass,
            school_year: 2022
          }
        ]
      end

        organizations = *reader.each_organization
        case organizations
        in [
          {
            sourced_id: org_sourced_id,
            name: "\u5C0F\u5B66\u6821",
            type: "school",
            identifier: "B101200000019",
            parent_sourced_id: NilClass
          }
        ]
      end

        courses = *reader.each_course
        case courses
        in [
          {
            sourced_id: course_sourced_id,
            school_year_sourced_id: ^school_year_sourced_id,
            title: "2022\u5E74\u5EA6",
            course_code: nil,
            grades: [],
            org_sourced_id: ^org_sourced_id,
            subjects: [],
            subject_codes: []
          }
        ]
      end

        classes = *reader.each_class
        case classes
        in [
          {
            sourced_id: classroom_sourced_id,
            title: "1\u5E741\u7D44",
            grades: ["P1"],
            course_sourced_id: ^course_sourced_id,
            class_code: NilClass,
            class_type: "homeroom",
            location: NilClass,
            school_sourced_id: ^org_sourced_id,
            term_sourced_ids: [^school_year_sourced_id],
            subjects: [],
            subject_codes: [],
            periods: [],
            special_needs: NilClass
          }
        ]
      end

        users = *reader.each_user
        case users
        in [
          {
            sourced_id: user_sourced_id,
            enabled_user: true,
            username: "john.doe@example.com",
            user_ids: [],
            given_name: "John",
            family_name: "Doe",
            middle_name: NilClass,
            identifier: NilClass,
            email: NilClass,
            sms: NilClass,
            phone: NilClass,
            agent_sourced_ids: [],
            grades: [],
            password: NilClass,
            user_master_identifier: NilClass,
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
      end

        demographics = *reader.each_demographic
        case demographics
        in [
          {
            sourced_id: ^user_sourced_id,
            birth_date: NilClass,
            sex: "male",
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
      end

        user_profiles = *reader.each_user_profile
        case user_profiles
        in [
          {
            sourced_id: user_profile_sourced_id,
            user_sourced_id: ^user_sourced_id,
            profile_type: "example",
            vendor_id: "example",
            application_id: nil,
            description: NilClass,
            credential_type: "example",
            username: "example",
            password: NilClass
          }
        ]
      end

        roles = *reader.each_role
        case roles
        in [
          {
            sourced_id: String,
            user_sourced_id: ^user_sourced_id,
            role_type: "primary",
            role: "student",
            begin_date: NilClass,
            end_date: NilClass,
            org_sourced_id: ^org_sourced_id,
            user_profile_sourced_id: ^user_profile_sourced_id
          }
        ]
      end

        enrollments = *reader.each_enrollment
        case enrollments
        in [
          {
            sourced_id: String,
            class_sourced_id: ^classroom_sourced_id,
            school_sourced_id: ^org_sourced_id,
            user_sourced_id: ^user_sourced_id,
            role: "student",
            begin_date: NilClass,
            end_date: NilClass,
            shusseki_no: NilClass,
            public_flg: NilClass
          }
        ]
      end
      end
    end.not_to raise_error
  end
end
