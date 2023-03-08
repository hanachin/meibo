# frozen_string_literal: true

RSpec.describe Meibo::JapanProfile::OrganizationSet do
  describe "#check_semantically_consistent" do
    it "does not raise error if school does not have parent organization" do
      school = build(:meibo_organization, :jp, :elementary_school)
      roster = build(:meibo_roster)
      org_set = described_class.new([school], roster: roster)
      expect { org_set.check_semantically_consistent }.not_to raise_error
    end

    it "does not raise error if school have parent organization" do
      district = build(:meibo_organization, :jp, :district)
      school = build(:meibo_organization, :jp, :elementary_school, parent: district)
      roster = build(:meibo_roster)
      org_set = described_class.new([district, school], roster: roster)
      expect { org_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if district have parent organization" do
      parent_district = build(:meibo_organization, :jp, :district)
      district = build(:meibo_organization, :jp, :district, parent: parent_district)
      school = build(:meibo_organization, :jp, :elementary_school, parent: district)
      roster = build(:meibo_roster)
      org_set = described_class.new([parent_district, district, school], roster: roster)
      expect { org_set.check_semantically_consistent }.to raise_error(Meibo::InvalidDataTypeError)
    end
  end
end
