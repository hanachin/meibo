# frozen_string_literal: true

RSpec.describe Meibo::Roster do
  let(:roster_io) { StringIO.new }

  before do
    profile = Meibo::JapanProfile.new
    roster = Meibo::Roster.new(profile:)
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
      user:,
      user_profile:,
      role: Meibo::JapanProfile::Role::ROLES[:student],
      role_type: Meibo::JapanProfile::Role::TYPES[:primary]
    )
    classroom.build_enrollment(
      user:,
      role: Meibo::JapanProfile::Enrollment::ROLES[:student]
    )
    roster.write_to_buffer(roster_io)
  end

  it "works" do
    roster = Meibo::Roster.from_buffer(roster_io, profile: Meibo::JapanProfile.new)

    academic_sessions = *roster.academic_sessions
    start_date = Date.new(2022, 4, 1)
    end_date = Date.new(2023, 3, 31)
    academic_sessions => [
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
    organizations = *roster.organizations
    organizations => [
      {
        sourced_id: org_sourced_id,
        name: "\u5C0F\u5B66\u6821",
        type: "school",
        identifier: "B101200000019",
        parent_sourced_id: NilClass
      }
    ]
    courses = *roster.courses
    courses => [
      {
        sourced_id: course_sourced_id,
        school_year_sourced_id: ^school_year_sourced_id,
        title: "2022\u5E74\u5EA6",
        course_code: "",
        grades: [],
        org_sourced_id: ^org_sourced_id,
        subjects: [],
        subject_codes: []
      }
    ]
    classes = *roster.classes
    classes => [
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
    users = *roster.users
    users => [
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
    demographics = *roster.demographics
    demographics => [
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
    user_profiles = *roster.user_profiles
    user_profiles => [
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
    roles = *roster.roles
    roles => [
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
    enrollments = *roster.enrollments
    enrollments => [
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

    Meibo.with_roster(roster) do
      # make sure relation methods works
      academic_sessions[0].collection
      academic_sessions[0].parent
      academic_sessions[0].children
      classes[0].collection
      classes[0].course
      classes[0].school
      classes[0].terms
      classes[0].enrollments
      courses[0].collection
      courses[0].classes
      courses[0].organization
      courses[0].school_year
      demographics[0].collection
      demographics[0].user
      enrollments[0].collection
      enrollments[0].classroom
      enrollments[0].school
      enrollments[0].user
      organizations[0].collection
      organizations[0].parent
      organizations[0].children
      organizations[0].enrollments
      organizations[0].classes
      organizations[0].courses
      organizations[0].roles
      roles[0].collection
      roles[0].organization
      roles[0].user
      roles[0].user_profile
      user_profiles[0].collection
      user_profiles[0].user
      user_profiles[0].role
      users[0].collection
      users[0].agents
      users[0].demographic
      users[0].enrollments
      users[0].primary_organization
      users[0].roles
      users[0].user_profiles

      # lineno
      expect(academic_sessions[0].lineno).to be_kind_of(Integer)
      expect(classes[0].lineno).to be_kind_of(Integer)
      expect(courses[0].lineno).to be_kind_of(Integer)
      expect(demographics[0].lineno).to be_kind_of(Integer)
      expect(enrollments[0].lineno).to be_kind_of(Integer)
      expect(organizations[0].lineno).to be_kind_of(Integer)
      expect(roles[0].lineno).to be_kind_of(Integer)
      expect(user_profiles[0].lineno).to be_kind_of(Integer)
      expect(users[0].lineno).to be_kind_of(Integer)
    end
  end
end
