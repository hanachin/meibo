# frozen_string_literal: true

RSpec.describe Meibo::UserSet do
  describe '#check_semantically_consistent' do
    let(:primary_organization) { build(:meibo_organization, :elementary_school) }

    context 'When user has primary_organization' do
      let(:user) { build(:meibo_user, primary_organization: primary_organization) }

      it "does not raise error if primary organization found" do
        user_set = Meibo::UserSet.new([user], organization_set: Meibo::OrganizationSet.new([primary_organization]))
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if primary organization not found" do
        user_set = Meibo::UserSet.new([user], organization_set: Meibo::OrganizationSet.new([]))
        expect { user_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{primary_organization.sourced_id} /)
      end
    end

    context 'When user has not primary_organization' do
      let(:user) { build(:meibo_user, primary_organization: nil) }

      it "does not raise error" do
        user_set = Meibo::UserSet.new([user], organization_set: Meibo::OrganizationSet.new([]))
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
