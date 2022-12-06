# frozen_string_literal: true

require "factory_bot"
require "securerandom"

FactoryBot.define do
  factory :meibo_user, class: "Meibo::User" do
    initialize_with { new(**attributes) }

    transient do
      agents { [] }
      primary_organization { nil }
    end

    sourced_id { SecureRandom.uuid }
    sequence(:username) { |n| "user#{n}@example.com" }
    sequence(:given_name) { |n| "John#{n}" }
    sequence(:family_name) { |n| "Doe#{n}" }
    agent_sourced_ids { agents&.map(&:sourced_id) }
    primary_org_sourced_id { primary_organization&.sourced_id }

    trait :jp do
      initialize_with { Meibo::JapanProfile::User.new(**attributes) }

      transient do
        homeroom { nil }
      end

      home_class { homeroom&.sourced_id }
    end
  end
end
