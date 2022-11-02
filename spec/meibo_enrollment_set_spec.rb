# frozen_string_literal: true

RSpec.describe Meibo::EnrollmentSet do
  describe '#check_semantically_consistent' do
    let(:academic_session) { build(:meibo_academic_session) }
    let(:academic_session_set) { Meibo::AcademicSessionSet.new([academic_session]) }
    let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: [academic_session]) }
    let(:classroom_set) { Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set) }
    let(:course) { build(:meibo_course, organization: school) }
    let(:course_set) { Meibo::CourseSet.new([course], academic_session_set: academic_session_set, organization_set: organization_set) }
    let(:enrollment) { build(:meibo_enrollment, :teacher, classroom: classroom, school: school, user: user) }
    let(:organization_set) { Meibo::OrganizationSet.new([school]) }
    let(:school) { build(:meibo_organization, :elementary_school) }
    let(:user) { build(:meibo_user, primary_organization: school) }
    let(:user_set) { Meibo::UserSet.new([user], organization_set: organization_set) }

    describe 'classroom' do
      it "does not raise error if classroom found" do
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if classroom not found" do
        classroom_set = Meibo::ClassroomSet.new([], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{classroom.sourced_id} /)
      end
    end

    describe 'school' do
      it "does not raise error if school found" do
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if school not found" do
        organization_set = Meibo::OrganizationSet.new([])
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school.sourced_id} /)
      end
    end

    describe 'user' do
      it "does not raise error if user found" do
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if user not found" do
        user_set = Meibo::UserSet.new([], organization_set: organization_set)
        enrollment_set = Meibo::EnrollmentSet.new([enrollment], classroom_set: classroom_set, organization_set: organization_set, user_set: user_set)
        expect { enrollment_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
      end
    end
  end
end
