# frozen_string_literal: true

RSpec.describe Meibo::CourseSet do
  describe '#check_semantically_consistent' do
    let(:organization) { build(:meibo_organization, :elementary_school) }

    describe 'organization' do
      let(:academic_session_set) { Meibo::AcademicSessionSet.new([]) }
      let(:course) { build(:meibo_course, organization: organization) }

      it "does not raise error if organization found" do
        organization_set = Meibo::OrganizationSet.new([organization])
        course_set = Meibo::CourseSet.new([course], academic_session_set: academic_session_set, organization_set: organization_set)
        expect { course_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if organization not found" do
        organization_set = Meibo::OrganizationSet.new([])
        course_set = Meibo::CourseSet.new([course], academic_session_set: academic_session_set, organization_set: organization_set)
        expect { course_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{organization.sourced_id} /)
      end
    end

    describe 'school_year' do
      let(:course_with_school_year) { build(:meibo_course, organization: organization, school_year: school_year) }
      let(:organization_set) { Meibo::OrganizationSet.new([organization]) }
      let(:school_year) { build(:meibo_academic_session) }

      it "does not raise error if school_year found" do
        academic_session_set = Meibo::AcademicSessionSet.new([school_year])
        course_set = Meibo::CourseSet.new([course_with_school_year], academic_session_set: academic_session_set, organization_set: organization_set)
        expect { course_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if school_year not found" do
        academic_session_set = Meibo::AcademicSessionSet.new([])
        course_set = Meibo::CourseSet.new([course_with_school_year], academic_session_set: academic_session_set, organization_set: organization_set)
        expect { course_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school_year.sourced_id} /)
      end
    end
  end
end
