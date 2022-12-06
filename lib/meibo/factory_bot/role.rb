# frozen_string_literal: true

require "factory_bot"
require "securerandom"

FactoryBot.define do
  factory :meibo_role, class: "Meibo::Role" do
    initialize_with { new(**attributes) }

    transient do
      user { nil }
      organization { nil }
      user_profile { nil }
    end

    sourced_id { SecureRandom.uuid }
    user_sourced_id { user&.sourced_id }
    org_sourced_id { organization&.sourced_id }
    user_profile_sourced_id { user_profile&.sourced_id }

    trait :primary do
      role_type { Meibo::Role::TYPES[:primary] }
    end

    trait :secondary do
      role_type { Meibo::Role::TYPES[:secondary] }
    end

    trait :aide do
      role { Meibo::Role::ROLES[:aide] }
    end

    trait :counselor do
      role { Meibo::Role::ROLES[:counselor] }
    end

    trait :district_administrator do
      role { Meibo::Role::ROLES[:district_administrator] }
    end

    trait :guardian do
      role { Meibo::Role::ROLES[:guardian] }
    end

    trait :parent do
      role { Meibo::Role::ROLES[:parent] }
    end

    trait :principal do
      role { Meibo::Role::ROLES[:principal] }
    end

    trait :proctor do
      role { Meibo::Role::ROLES[:proctor] }
    end

    trait :relative do
      role { Meibo::Role::ROLES[:relative] }
    end

    trait :site_administrator do
      role { Meibo::Role::ROLES[:site_administrator] }
    end

    trait :student do
      role { Meibo::Role::ROLES[:student] }
    end

    trait :system_administrator do
      role { Meibo::Role::ROLES[:system_administrator] }
    end

    trait :teacher do
      role { Meibo::Role::ROLES[:teacher] }
    end

    trait :jp do
      initialize_with { Meibo::JapanProfile::Role.new(**attributes) }
    end
  end
end
