# frozen_string_literal: true

module Meibo
  class UserProfileSet < DataSet
    def check_semantically_consistent
      super

      each do |user_profile|
        roster.users.find(user_profile.user_sourced_id)
      end
    end
  end
end
