# frozen_string_literal: true

RSpec.describe Meibo::JapanProfile::UserSet do
  describe '#check_semantically_consistent' do
    let(:school) { build(:meibo_organization, :elementary_school) }

    context 'When user has home_class' do
      let(:course) { build(:meibo_course, organization: school, school_year: school_year) }
      let(:home_class) { build(:meibo_classroom, course: course, school: school) }
      let(:school_year) { build(:meibo_academic_session) }
      let(:user) { build(:meibo_jp_user, primary_organization: school, homeroom: home_class) }

      it "does not raise error if home_class found" do
        roster = build(:meibo_roster, organizations: [school], classes: [home_class])
        user_set = Meibo::JapanProfile::UserSet.new([user], roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if primary organization not found" do
        roster = build(:meibo_roster, organizations: [school], classes: [])
        user_set = Meibo::JapanProfile::UserSet.new([user], roster: roster)
        expect { user_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{home_class.sourced_id} /)
      end
    end

    context 'When user has not home_class' do
      let(:user) { build(:meibo_jp_user, primary_organization: school) }

      it "does not raise error" do
        roster = build(:meibo_roster, organizations: [school], classes: [])
        user_set = Meibo::JapanProfile::UserSet.new([user], roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
