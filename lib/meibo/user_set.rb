# frozen_string_literal: true

module Meibo
  class UserSet < DataSet
    def check_semantically_consistent
      super

      raise Error, "userMasterIdentifier\u304C\u91CD\u8907\u3057\u3066\u3044\u307E\u3059" if @data.filter_map(&:user_master_identifier).tally.values.any? { |v| v > 1 }

      each do |user|
        roster.organizations.find(user.primary_org_sourced_id) if user.primary_org_sourced_id

        user.agent_sourced_ids.each do |agent_sourced_id|
          find(agent_sourced_id)
        end
      end
    end
  end
end
