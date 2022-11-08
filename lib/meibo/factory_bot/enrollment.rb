# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_enrollment, class: 'Meibo::Enrollment' do
    initialize_with { new(**attributes) }

    transient do
      classroom { nil }
      school { nil }
      user { nil }
    end

    sourced_id { SecureRandom.uuid }
    class_sourced_id { classroom&.sourced_id }
    school_sourced_id { school&.sourced_id }
    user_sourced_id { user&.sourced_id }

    trait :student do
      role { Meibo::Enrollment::ROLES[:student] }
    end

    trait :teacher do
      role { Meibo::Enrollment::ROLES[:teacher] }
    end

    trait :administrator do
      role { Meibo::Enrollment::ROLES[:administrator] }
    end

    trait :guardian do
      role { Meibo::Enrollment::ROLES[:guardian] }
    end

    trait :jp do
      initialize_with { Meibo::JapanProfile::Enrollment.new(**attributes) }
    end

    trait :public do
      public_flg { true }
    end

    trait :private do
      public_flg { false }
    end
  end
end
