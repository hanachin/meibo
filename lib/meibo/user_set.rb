# frozen_string_literal: true

module Meibo
  class UserSet < DataSet
    def check_semantically_consistent
      super

      raise Error, "userMasterIdentifierが重複しています" if !roster.profile.allow_duplicate_user_master_identifiers && @data.filter_map(&:user_master_identifier).tally.values.any? { |count| count > 1 }

      each do |user|
        roster.organizations.find(user.primary_org_sourced_id) if user.primary_org_sourced_id

        user.agent_sourced_ids.each do |agent_sourced_id|
          find(agent_sourced_id)
        end
      end
    end
  end
end
