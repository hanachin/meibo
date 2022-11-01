# frozen_string_literal: true

module Meibo
  class UserProfileSet < DataSet
    def initialize(data, user_set:)
      super(data)
      @user_set = user_set
    end

    def check_semantically_consistent
      super

      each do |user_profile|
        @user_set.find_by_sourced_id(user_profile.user_sourced_id)
      end
    end
  end
end
