# frozen_string_literal: true

RSpec.describe Meibo::CourseSet do
  describe "#check_semantically_consistent" do
    let(:organization) { build(:meibo_organization, :elementary_school) }

    describe "organization" do
      let(:course) { build(:meibo_course, organization:) }

      it "does not raise error if organization found" do
        roster = build(:meibo_roster, organizations: [organization])
        course_set = described_class.new([course], roster:)
        expect { course_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if organization not found" do
        roster = build(:meibo_roster)
        course_set = described_class.new([course], roster:)
        expect do
          course_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{organization.sourced_id} /)
      end
    end

    describe "school_year" do
      let(:course_with_school_year) { build(:meibo_course, organization:, school_year:) }
      let(:school_year) { build(:meibo_academic_session) }

      it "does not raise error if school_year found" do
        roster = build(:meibo_roster, academic_sessions: [school_year], organizations: [organization])
        course_set = described_class.new([course_with_school_year], roster:)
        expect { course_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if school_year not found" do
        roster = build(:meibo_roster, organizations: [organization])
        course_set = described_class.new([course_with_school_year], roster:)
        expect do
          course_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school_year.sourced_id} /)
      end
    end
  end
end
