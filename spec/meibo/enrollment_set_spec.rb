# frozen_string_literal: true

RSpec.describe Meibo::EnrollmentSet do
  describe "#check_semantically_consistent" do
    let(:academic_session) { build(:meibo_academic_session) }
    let(:classroom) { build(:meibo_classroom, school: school, course: course, terms: [academic_session]) }
    let(:course) { build(:meibo_course, organization: school) }
    let(:enrollment) { build(:meibo_enrollment, :teacher, classroom: classroom, school: school, user: user) }
    let(:school) { build(:meibo_organization, :elementary_school) }
    let(:user) { build(:meibo_user, primary_organization: school) }

    it "does not raise error if classroom/school/user found" do
      roster = build(:meibo_roster, classes: [classroom], organizations: [school], users: [user])
      enrollment_set = described_class.new([enrollment], roster: roster)
      expect { enrollment_set.check_semantically_consistent }.not_to raise_error
    end

    describe "classroom" do
      it "raise error if classroom not found" do
        roster = build(:meibo_roster, classes: [], organizations: [school], users: [user])
        enrollment_set = described_class.new([enrollment], roster: roster)
        expect do
          enrollment_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{classroom.sourced_id} /)
      end
    end

    describe "school" do
      it "raise error if school not found" do
        roster = build(:meibo_roster, classes: [classroom], organizations: [], users: [user])
        enrollment_set = described_class.new([enrollment], roster: roster)
        expect do
          enrollment_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{school.sourced_id} /)
      end
    end

    describe "user" do
      it "raise error if user not found" do
        roster = build(:meibo_roster, classes: [classroom], organizations: [school], users: [])
        enrollment_set = described_class.new([enrollment], roster: roster)
        expect do
          enrollment_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
      end
    end

    describe "primary" do
      context "when role teacher and primary = true" do
        let(:enrollment) { build(:meibo_enrollment, :teacher, classroom: classroom, school: school, user: user, primary: true) }

        it "does not raise error" do
          roster = build(:meibo_roster, classes: [classroom], organizations: [school], users: [user])
          enrollment_set = described_class.new([enrollment], roster: roster)
          expect { enrollment_set.check_semantically_consistent }.not_to raise_error
        end
      end

      context "when role student and primary = true" do
        let(:enrollment) { build(:meibo_enrollment, :student, classroom: classroom, school: school, user: user, primary: true) }

        it "does not raise error" do
          roster = build(:meibo_roster, classes: [classroom], organizations: [school], users: [user])
          enrollment_set = described_class.new([enrollment], roster: roster)
          expect { enrollment_set.check_semantically_consistent }.to raise_error(Meibo::InvalidDataTypeError)
        end
      end
    end
  end
end
