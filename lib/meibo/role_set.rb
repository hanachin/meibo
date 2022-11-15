# frozen_string_literal: true

module Meibo
  class RoleSet < DataSet
    def check_semantically_consistent
      super

      each do |role|
        roster.organizations.find(role.org_sourced_id)
        roster.users.find(role.user_sourced_id)

        if role.user_profile_sourced_id
          roster.user_profiles.find(role.user_profile_sourced_id)
        end
      end
    end

    def primary
      @cache[:primary] ||= new(select(&:primary?))
    end

    def secondary
      @cache[:secondary] ||= new(select(&:secondary?))
    end

    def aide
      @cache[:aide] ||= new(select(&:aide?))
    end

    def counselor
      @cache[:counselor] ||= new(select(&:counselor?))
    end

    def district_administrator
      @cache[:district_administrator] ||= new(select(&:district_administrator?))
    end

    def guardian
      @cache[:guardian] ||= new(select(&:guardian?))
    end

    def parent
      @cache[:parent] ||= new(select(&:parent?))
    end

    def principal
      @cache[:principal] ||= new(select(&:principal?))
    end

    def proctor
      @cache[:proctor] ||= new(select(&:proctor?))
    end

    def relative
      @cache[:relative] ||= new(select(&:relative?))
    end

    def site_administrator
      @cache[:site_administrator] ||= new(select(&:site_administrator?))
    end

    def student
      @cache[:student] ||= new(select(&:student?))
    end

    def system_administrator
      @cache[:system_administrator] ||= new(select(&:system_administrator?))
    end

    def teacher
      @cache[:teacher] ||= new(select(&:teacher?))
    end
  end
end
