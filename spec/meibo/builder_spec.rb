# frozen_string_literal: true

RSpec.describe Meibo::Builder do
  it "works good" do
    roster = Meibo::Roster.new
    builder = described_class.new(roster:, profile: Meibo::JapanProfile.new)
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
  end
end
