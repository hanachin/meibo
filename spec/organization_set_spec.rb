# frozen_string_literal: true

RSpec.describe Meibo::OrganizationSet do
  describe '#check_semantically_consistent' do
    let(:parent_organization) { build(:meibo_organization, :elementary_school) }
    let(:organization) { build(:meibo_organization, :elementary_school, parent: parent_organization) }

    it "does not raise error if parent found" do
      organization_set = Meibo::OrganizationSet.new([organization, parent_organization])
      expect { organization_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if parent not found" do
      organization_set = Meibo::OrganizationSet.new([organization])
      expect { organization_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{parent_organization.sourced_id} /)
    end
  end
end
