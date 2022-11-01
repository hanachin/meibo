# frozen_string_literal: true

RSpec.describe Meibo::RoleSet do
  describe '#check_semantically_consistent' do
    let(:user) { build(:meibo_user) }
    let(:organization) { build(:meibo_organization, :elementary_school) }
    let(:organization_set) { Meibo::OrganizationSet.new([organization]) }

    describe 'organization' do
      let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profile: nil) }
      let(:user_profile_set) { Meibo::UserProfileSet.new([], user_set: Meibo::UserSet.new([user], organization_set: organization_set)) }
      let(:user_set) { Meibo::UserSet.new([user], organization_set: organization_set) }

      it 'does not raise error if user found' do
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.not_to raise_error
      end

      it 'raise error if organization not found' do
        organization_set = Meibo::OrganizationSet.new([])
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataSet::DataNotFoundError, /sourcedId: #{organization.sourced_id} /)
      end
    end

    describe 'user' do
      let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profile: nil) }
      let(:user_profile_set) { Meibo::UserProfileSet.new([], user_set: Meibo::UserSet.new([user], organization_set: organization_set)) }

      it 'does not raise error if user found' do
        user_set = Meibo::UserSet.new([user], organization_set: organization_set)
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.not_to raise_error
      end

      it 'raise error if user not found' do
        user_set = Meibo::UserSet.new([], organization_set: organization_set)
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataSet::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
      end
    end

    context 'When role has user profile' do
      let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profile: user_profile) }
      let(:user_profile) { build(:meibo_user_profile, user: user) }
      let(:user_set) { Meibo::UserSet.new([user], organization_set: organization_set) }

      it "does not raise error if user profile found" do
        user_profile_set = Meibo::UserProfileSet.new([user_profile], user_set: user_set)
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.not_to raise_error
      end

      it "raise error if user profile not found" do
        user_profile_set = Meibo::UserProfileSet.new([], user_set: user_set)
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataSet::DataNotFoundError, /sourcedId: #{user_profile.sourced_id} /)
      end
    end

    context 'When role has not user profile' do
      let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profile: nil) }
      let(:user_profile) { build(:meibo_user_profile, user: user) }
      let(:user_profile_set) { Meibo::UserProfileSet.new([user_profile], user_set: user_set) }
      let(:user_set) { Meibo::UserSet.new([user], organization_set: organization_set) }

      it 'does not raise error' do
        role_set = Meibo::RoleSet.new([role], organization_set: organization_set, user_set: user_set, user_profile_set: user_profile_set)
        expect { role_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
