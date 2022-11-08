# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_demographic, class: 'Meibo::Demographic' do
    initialize_with { new(**attributes) }

    transient do
      user { nil }
    end

    sourced_id { user&.sourced_id || SecureRandom.uuid }

    trait :jp do
      initialize_with { Meibo::JapanProfile::Demographic.new(**attributes) }
    end
  end
end
