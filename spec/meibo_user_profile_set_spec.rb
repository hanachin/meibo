# frozen_string_literal: true

RSpec.describe Meibo::UserProfileSet do
  describe '#check_semantically_consistent' do
    let(:user) { build(:meibo_user) }
    let(:user_profile) { build(:meibo_user_profile, user: user) }

    it "does not raise error if user found" do
      roster = build(:meibo_roster, users: [user])
      demographic_set = Meibo::UserProfileSet.new([user_profile], roster: roster)
      expect { demographic_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if user not found" do
      roster = build(:meibo_roster, users: [])
      demographic_set = Meibo::UserProfileSet.new([user_profile], roster: roster)
      expect { demographic_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
    end
  end
end
