# frozen_string_literal: true

RSpec.describe Meibo::Course do
  describe "#school_year" do
    let(:organization) { build(:meibo_organization, :elementary_school) }

    let(:course_with_school_year) { build(:meibo_course, organization: organization, school_year: school_year) }
    let(:school_year) { build(:meibo_academic_session) }

    it "does not raise error if school_year found" do
      roster = build(:meibo_roster, academic_sessions: [school_year], organizations: [organization])
      Meibo.with_roster(roster) do
        expect { course_with_school_year.school_year }.not_to raise_error
      end
    end

    it "raise error if school_year not found" do
      roster = build(:meibo_roster, academic_sessions: [], organizations: [organization])
      Meibo.with_roster(roster) do
        expect { course_with_school_year.school_year }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school_year.sourced_id} /)
      end
    end

    context "when school_year is nil" do
      let(:school_year) { nil }

      it "does not raise error" do
        roster = build(:meibo_roster, academic_sessions: [], organizations: [organization])
        Meibo.with_roster(roster) do
          expect { course_with_school_year.school_year }.not_to raise_error
        end
      end
    end
  end
end
