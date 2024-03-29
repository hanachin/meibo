# frozen_string_literal: true

RSpec.describe Meibo::ClassroomSet do
  describe "#check_semantically_consistent" do
    let(:academic_session) { build(:meibo_academic_session) }
    let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: [academic_session]) }
    let(:course) { build(:meibo_course, organization: school) }
    let(:school) { build(:meibo_organization, :elementary_school) }

    it "does not raise error if course/school/terms found" do
      roster = build(:meibo_roster, academic_sessions: [academic_session], courses: [course], organizations: [school])
      classroom_set = described_class.new([classroom], roster: roster)
      expect { classroom_set.check_semantically_consistent }.not_to raise_error
    end

    describe "course" do
      it "raise error if course not found" do
        roster = build(:meibo_roster, academic_sessions: [academic_session], courses: [], organizations: [school])
        classroom_set = described_class.new([classroom], roster: roster)
        expect do
          classroom_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{course.sourced_id} /)
      end
    end

    describe "school" do
      it "raise error if school not found" do
        roster = build(:meibo_roster, academic_sessions: [academic_session], courses: [course], organizations: [])
        classroom_set = described_class.new([classroom], roster: roster)
        expect do
          classroom_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school.sourced_id} /)
      end
    end

    describe "terms" do
      it "raise error if term not found" do
        roster = build(:meibo_roster, academic_sessions: [], courses: [course], organizations: [school])
        classroom_set = described_class.new([classroom], roster: roster)
        expect do
          classroom_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{academic_session.sourced_id} /)
      end

      context "when empty terms" do
        let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: []) }

        it "raise error" do
          roster = build(:meibo_roster, academic_sessions: [academic_session], courses: [course],
                                        organizations: [school])
          classroom_set = described_class.new([classroom], roster: roster)
          expect do
            classroom_set.check_semantically_consistent
          end.to raise_error(Meibo::DataNotFoundError, "termSourcedIdは1つ以上指定してください")
        end
      end
    end
  end
end
