# frozen_string_literal: true

module Meibo
  class DemographicSet < DataSet
    def check_semantically_consistent
      super

      each do |demographic|
        roster.users.find(demographic.sourced_id)
      end
    end

    def male
      @cache[:male] ||= new(select(&:male?))
    end

    def female
      @cache[:female] ||= new(select(&:female?))
    end

    def unspecified
      @cache[:unspecified] ||= new(select(&:unspecified?))
    end

    def other
      @cache[:other] ||= new(select(&:other?))
    end
  end
end
