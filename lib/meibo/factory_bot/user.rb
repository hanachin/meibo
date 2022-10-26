# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_user, class: 'Meibo::User' do
    initialize_with { new(**attributes) }

    transient do
      agents { [] }
      primary_organization { nil }
    end

    sourced_id { SecureRandom.uuid }
    sequence(:username) {|n| "user#{n}@example.com" }
    sequence(:given_name) {|n| "John#{n}" }
    sequence(:family_name) {|n| "Doe#{n}" }
  end
end
