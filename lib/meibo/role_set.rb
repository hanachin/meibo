# frozen_string_literal: true

module Meibo
  class RoleSet < DataSet
    def initialize(data, user_set:, user_profile_set:)
      super(data)
      @user_set = user_set
      @user_profile_set = user_profile_set
    end

    def check_semantically_consistent
      super

      each do |role|
        @user_set.find_by_sourced_id(role.user_sourced_id)

        if role.user_profile_sourced_id
          @user_profile_set.find_by_sourced_id(role.user_profile_sourced_id)
        end
      end
    end
  end
end
