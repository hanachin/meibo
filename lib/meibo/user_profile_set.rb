# frozen_string_literal: true

module Meibo
  class UserProfileSet < DataSet
    def check_semantically_consistent
      super

      each do |user_profile|
        roster.users.find_by_sourced_id(user_profile.user_sourced_id)
      end
    end
  end
end
