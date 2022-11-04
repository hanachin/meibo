# frozen_string_literal: true

module Meibo
  class UserSet < DataSet
    def check_semantically_consistent
      super

      each do |user|
        if user.primary_org_sourced_id
          roster.organizations.find_by_sourced_id(user.primary_org_sourced_id)
        end

        user.agent_sourced_ids.each do |agent_sourced_id|
          find_by_sourced_id(agent_sourced_id)
        end
      end
    end
  end
end
