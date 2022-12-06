# frozen_string_literal: true

RSpec.describe Meibo::DemographicSet do
  describe "#check_semantically_consistent" do
    let(:user) { build(:meibo_user) }
    let(:demographic) { build(:meibo_demographic, user: user) }

    it "does not raise error if user found" do
      roster = build(:meibo_roster, users: [user])
      demographic_set = described_class.new([demographic], roster: roster)
      expect { demographic_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if user not found" do
      roster = build(:meibo_roster)
      demographic_set = described_class.new([demographic], roster: roster)
      expect do
        demographic_set.check_semantically_consistent
      end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
    end
  end
end
