# frozen_string_literal: true

RSpec.describe Meibo::OrganizationSet do
  describe "#check_semantically_consistent" do
    let(:organization) { build(:meibo_organization, :elementary_school, parent: parent_organization) }
    let(:parent_organization) { build(:meibo_organization, :elementary_school) }
    let(:roster) { build(:meibo_roster) }

    it "does not raise error if parent found" do
      organization_set = described_class.new([organization, parent_organization], roster: roster)
      expect { organization_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if parent not found" do
      organization_set = described_class.new([organization], roster: roster)
      expect do
        organization_set.check_semantically_consistent
      end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{parent_organization.sourced_id} /)
    end
  end
end
