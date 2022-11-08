# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_user_profile, class: 'Meibo::UserProfile' do
    initialize_with { new(**attributes) }

    transient do
      user { nil }
    end

    sourced_id { SecureRandom.uuid }
    user_sourced_id { user&.sourced_id }
    profile_type { 'meibo test' }
    vendor_id { 'meibo' }
    credential_type { 'plain' }
    sequence(:username) {|n| "user#{n}"}

    trait :jp do
      initialize_with { Meibo::JapanProfile::UserProfile.new(**attributes) }
    end
  end
end
