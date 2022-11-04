# frozen_string_literal: true

module Meibo
  class RoleSet < DataSet
    def check_semantically_consistent
      super

      each do |role|
        roster.organizations.find(role.org_sourced_id)
        roster.users.find(role.user_sourced_id)

        if role.user_profile_sourced_id
          roster.user_profiles.find(role.user_profile_sourced_id)
        end
      end
    end
  end
end
