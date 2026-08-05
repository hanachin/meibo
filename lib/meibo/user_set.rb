# frozen_string_literal: true

module Meibo
  class UserSet < DataSet
    def check_semantically_consistent
      super

      each do |user|
        roster.organizations.find(user.primary_org_sourced_id) if user.primary_org_sourced_id

        user.agent_sourced_ids.each do |agent_sourced_id|
          find(agent_sourced_id)
        end
      end
    end
  end
end
