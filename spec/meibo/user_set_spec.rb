# frozen_string_literal: true

RSpec.describe Meibo::UserSet do
  describe "#check_semantically_consistent" do
    context "when user has primary_organization" do
      let(:primary_organization) { build(:meibo_organization, :elementary_school) }
      let(:user) { build(:meibo_user, primary_organization:) }

      it "does not raise error if primary organization found" do
        roster = build(:meibo_roster, organizations: [primary_organization])
        user_set = described_class.new([user], roster:)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if primary organization not found" do
        roster = build(:meibo_roster)
        user_set = described_class.new([user], roster:)
        expect do
          user_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{primary_organization.sourced_id} /)
      end
    end

    context "when user has not primary_organization" do
      let(:user) { build(:meibo_user, primary_organization: nil) }

      it "does not raise error" do
        roster = build(:meibo_roster)
        user_set = described_class.new([user], roster:)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
