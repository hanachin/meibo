# frozen_string_literal: true

RSpec.describe Meibo::ClassroomSet do
  describe '#check_semantically_consistent' do
    let(:academic_session) { build(:meibo_academic_session) }
    let(:academic_session_set) { Meibo::AcademicSessionSet.new([academic_session]) }
    let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: [academic_session]) }
    let(:course) { build(:meibo_course, organization: school) }
    let(:course_set) { Meibo::CourseSet.new([course], academic_session_set: academic_session_set, organization_set: organization_set) }
    let(:school) { build(:meibo_organization, :elementary_school) }
    let(:organization_set) { Meibo::OrganizationSet.new([school]) }

    describe 'course' do
      it "does not raise error if course found" do
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if course not found" do
        course_set = Meibo::CourseSet.new([], academic_session_set: academic_session_set, organization_set: organization_set)
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{course.sourced_id} /)
      end
    end

    describe 'school' do
      it "does not raise error if school found" do
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if school not found" do
        organization_set = Meibo::OrganizationSet.new([])
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school.sourced_id} /)
      end
    end

    describe 'terms' do
      it "does not raise error if term found" do
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if term not found" do
        academic_session_set = Meibo::AcademicSessionSet.new([])
        classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
        expect { classroom_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{academic_session.sourced_id} /)
      end

      context 'empty' do
        let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: []) }

        it "raise error" do
          academic_session_set = Meibo::AcademicSessionSet.new([])
          classroom_set = Meibo::ClassroomSet.new([classroom], academic_session_set: academic_session_set, course_set: course_set, organization_set: organization_set)
          expect { classroom_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, 'termSourcedIdは1つ以上指定してください')
        end
      end
    end
  end
end
