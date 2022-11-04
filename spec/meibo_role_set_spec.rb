# frozen_string_literal: true

RSpec.describe Meibo::RoleSet do
  describe '#check_semantically_consistent' do
    let(:organization) { build(:meibo_organization, :elementary_school) }
    let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profile: user_profile) }
    let(:user) { build(:meibo_user) }
    let(:user_profile) { build(:meibo_user_profile, user: user) }

    it 'does not raise error if user/organization/user_profile found' do
      roster = build(:meibo_roster, organizations: [organization], users: [user], user_profiles: [user_profile])
      role_set = Meibo::RoleSet.new([role], roster: roster)
      expect { role_set.check_semantically_consistent }.not_to raise_error
    end
  
    describe 'organization' do
      it 'raise error if organization not found' do
        roster = build(:meibo_roster, organizations: [], users: [user], user_profiles: [user_profile])
        role_set = Meibo::RoleSet.new([role], roster: roster)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{organization.sourced_id} /)
      end
    end

    describe 'user' do
      it 'raise error if user not found' do
        roster = build(:meibo_roster, organizations: [organization], users: [], user_profiles: [user_profile])
        role_set = Meibo::RoleSet.new([role], roster: roster)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user.sourced_id} /)
      end
    end

    describe 'user profile' do
      it "raise error if user profile not found" do
        roster = build(:meibo_roster, organizations: [organization], users: [user], user_profiles: [])
        role_set = Meibo::RoleSet.new([role], roster: roster)
        expect { role_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{user_profile.sourced_id} /)
      end
    end

    context 'When role has not user_profile' do
      let(:role) { build(:meibo_role, :teacher, :primary, organization: organization, user: user, user_profiles: nil) }

      it 'does not raise error' do
        roster = build(:meibo_roster, organizations: [organization], users: [user], user_profiles: [])
        role_set = Meibo::RoleSet.new([role], roster: roster)
        expect { role_set.check_semantically_consistent }.not_to raise_error
      end
    end
  end
end
