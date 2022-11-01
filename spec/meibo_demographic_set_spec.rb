# frozen_string_literal: true

RSpec.describe Meibo::DemographicSet do
  describe '#check_semantically_consistent' do
    let(:user) { build(:meibo_user) }
    let(:demographic) { build(:meibo_demographic, user: user) }
    let(:organization_set) { Meibo::OrganizationSet.new([]) }

    it "does not raise error if user found" do
      demographic_set = Meibo::DemographicSet.new([demographic], user_set: Meibo::UserSet.new([user], organization_set: organization_set))
      expect { demographic_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if user not found" do
      demographic_set = Meibo::DemographicSet.new([demographic], user_set: Meibo::UserSet.new([], organization_set: organization_set))
      expect { demographic_set.check_semantically_consistent }.to raise_error(Meibo::DataSet::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
    end
  end
end
