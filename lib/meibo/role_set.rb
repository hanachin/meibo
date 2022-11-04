# frozen_string_literal: true

module Meibo
  class RoleSet < DataSet
    def check_semantically_consistent
      super

      each do |role|
        roster.organizations.find_by_sourced_id(role.org_sourced_id)
        roster.users.find_by_sourced_id(role.user_sourced_id)

        if role.user_profile_sourced_id
          roster.user_profiles.find_by_sourced_id(role.user_profile_sourced_id)
        end
      end
    end
  end
end
