# frozen_string_literal: true

RSpec.describe Meibo::UserSet do
  describe "#check_semantically_consistent" do
    context "when userMasterIdentifier is duplicated" do
      it "does not raise error" do
        roster = build(:meibo_roster)
        users = build_list(:meibo_user, 2, user_master_identifier: "foo")
        user_set = described_class.new(users, roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end

      it "does not raise error when users belong to the same organization" do
        organization = build(:meibo_organization, :elementary_school)
        users = build_list(:meibo_user, 2, user_master_identifier: "foo", primary_organization: organization)
        roster = build(:meibo_roster, organizations: [organization], users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end

      it "does not raise error when users belong to different organizations" do
        organizations = build_list(:meibo_organization, 2, :elementary_school)
        users = organizations.map do |organization|
          build(:meibo_user, user_master_identifier: "foo", primary_organization: organization)
        end
        roster = build(:meibo_roster, organizations: organizations, users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end

      it "does not raise error when users have the same role" do
        organization = build(:meibo_organization, :elementary_school)
        users = build_list(:meibo_user, 2, user_master_identifier: "foo", primary_organization: organization)
        roles = users.map { |user| build(:meibo_role, :teacher, :primary, organization: organization, user: user) }
        roster = build(:meibo_roster, organizations: [organization], roles: roles, users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end

      it "does not raise error when users have different roles" do
        organization = build(:meibo_organization, :elementary_school)
        users = build_list(:meibo_user, 2, user_master_identifier: "foo", primary_organization: organization)
        roles = [
          build(:meibo_role, :teacher, :primary, organization: organization, user: users[0]),
          build(:meibo_role, :student, :primary, organization: organization, user: users[1])
        ]
        roster = build(:meibo_roster, organizations: [organization], roles: roles, users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end
    end

    context "when userMasterIdentifier is blank" do
      it "raise error" do
        roster = build(:meibo_roster)
        users = build_list(:meibo_user, 2, user_master_identifier: nil)
        user_set = described_class.new(users, roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end
    end

    context "when duplicate userMasterIdentifier values are disallowed" do
      let(:profile) do
        base_profile = Meibo.current_profile
        Meibo::Profile.new(
          builders: base_profile.builders,
          data_models: base_profile.data_models,
          data_set: base_profile.data_set,
          manifest_properties: base_profile.manifest_properties,
          allow_duplicate_user_master_identifiers: false
        )
      end

      it "raises the original error for duplicate values" do
        users = build_list(:meibo_user, 2, user_master_identifier: "foo")
        roster = build(:meibo_roster, profile: profile, users: users)

        expect { roster.check_semantically_consistent }.to raise_error(Meibo::Error, "userMasterIdentifierが重複しています")
      end

      it "rejects duplicates across organizations" do
        organizations = build_list(:meibo_organization, 2, :elementary_school)
        users = organizations.map do |organization|
          build(:meibo_user, user_master_identifier: "foo", primary_organization: organization)
        end
        roster = build(:meibo_roster, profile: profile, organizations: organizations, users: users)

        expect { roster.check_semantically_consistent }.to raise_error(Meibo::Error, "userMasterIdentifierが重複しています")
      end

      it "rejects duplicates across roles" do
        organization = build(:meibo_organization, :elementary_school)
        users = build_list(:meibo_user, 2, user_master_identifier: "foo", primary_organization: organization)
        roles = [
          build(:meibo_role, :teacher, :primary, organization: organization, user: users[0]),
          build(:meibo_role, :student, :primary, organization: organization, user: users[1])
        ]
        roster = build(:meibo_roster, profile: profile, organizations: [organization], roles: roles, users: users)

        expect { roster.check_semantically_consistent }.to raise_error(Meibo::Error, "userMasterIdentifierが重複しています")
      end

      it "accepts unique values" do
        users = [build(:meibo_user, user_master_identifier: "foo"), build(:meibo_user, user_master_identifier: "bar")]
        roster = build(:meibo_roster, profile: profile, users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end

      it "ignores nil values as before" do
        users = build_list(:meibo_user, 2, user_master_identifier: nil)
        roster = build(:meibo_roster, profile: profile, users: users)

        expect { roster.check_semantically_consistent }.not_to raise_error
      end

      it "does not change validation for other profiles" do
        users = build_list(:meibo_user, 2, user_master_identifier: "foo")
        strict_roster = build(:meibo_roster, profile: profile, users: users)
        default_roster = build(:meibo_roster, users: users)

        expect { strict_roster.check_semantically_consistent }.to raise_error(Meibo::Error, "userMasterIdentifierが重複しています")
        expect { default_roster.check_semantically_consistent }.not_to raise_error
      end
    end

    context "when user has primary_organization" do
      let(:primary_organization) { build(:meibo_organization, :elementary_school) }
      let(:user) { build(:meibo_user, primary_organization: primary_organization) }

      it "does not raise error if primary organization found" do
        roster = build(:meibo_roster, organizations: [primary_organization])
        user_set = described_class.new([user], roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if primary organization not found" do
        roster = build(:meibo_roster)
        user_set = described_class.new([user], roster: roster)
        expect do
          user_set.check_semantically_consistent
        end.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{primary_organization.sourced_id} /)
      end
    end

    context "when user has not primary_organization" do
      let(:user) { build(:meibo_user, primary_organization: nil) }

      it "does not raise error" do
        roster = build(:meibo_roster)
        user_set = described_class.new([user], roster: roster)
        expect { user_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
