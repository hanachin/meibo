# frozen_string_literal: true

module Meibo
  class OrganizationSet < DataSet
    def check_semantically_consistent
      super

      each do |organization|
        next unless organization.parent_sourced_id

        find_by_sourced_id(organization.parent_sourced_id)
      end
    end
  end
end
