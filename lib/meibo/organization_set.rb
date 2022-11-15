# frozen_string_literal: true

module Meibo
  class OrganizationSet < DataSet
    def check_semantically_consistent
      super

      each do |organization|
        next unless organization.parent_sourced_id

        find(organization.parent_sourced_id)
      end
    end

    def department
      @cache[:department] ||= new(select(&:department?))
    end

    def school
      @cache[:school] ||= new(select(&:school?))
    end

    def district
      @cache[:district] ||= new(select(&:district?))
    end

    def local
      @cache[:local] ||= new(select(&:local?))
    end

    def state
      @cache[:state] ||= new(select(&:state?))
    end

    def national
      @cache[:national] ||= new(select(&:national?))
    end
  end
end
