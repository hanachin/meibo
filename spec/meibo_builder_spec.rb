# frozen_string_literal: true

RSpec.describe Meibo::Builder do
  it "works" do
    package = Meibo::MemoryPackage.new
    builder = Meibo::Builder.new(package: package)
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
  end
end
