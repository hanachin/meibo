# frozen_string_literal: true

module Meibo
  class DemographicSet < DataSet
    def check_semantically_consistent
      super

      each do |demographic|
        roster.users.find_by_sourced_id(demographic.sourced_id)
      end
    end
  end
end
