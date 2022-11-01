# frozen_string_literal: true

module Meibo
  class DemographicSet < DataSet
    def initialize(data, user_set:)
      super(data)
      @user_set = user_set
    end

    def check_semantically_consistent
      super

      each do |demographic|
        @user_set.find_by_sourced_id(demographic.sourced_id)
      end
    end
  end
end
