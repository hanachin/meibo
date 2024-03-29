# frozen_string_literal: true

require "factory_bot"
require "securerandom"

FactoryBot.define do
  factory :meibo_user, class: "Meibo::User" do
    initialize_with do
      case oneroster_version
      when "1.2.1"
        new(**attributes)
      when "1.2", "1.2.0"
        Meibo::UserM0.new(**attributes)
      end
    end

    transient do
      agents { [] }
      primary_organization { nil }
      oneroster_version { "1.2.1" }
    end

    sourced_id { SecureRandom.uuid }
    sequence(:username) { |n| "user#{n}@example.com" }
    sequence(:given_name) { |n| "John#{n}" }
    sequence(:family_name) { |n| "Doe#{n}" }
    agent_sourced_ids { agents&.map(&:sourced_id) }
    primary_org_sourced_id { primary_organization&.sourced_id }

    trait :id do
      user_master_identifier { SecureRandom.uuid }
    end

    trait :jp do
      initialize_with do
        case oneroster_version
        when "1.2.1"
          Meibo::JapanProfile::User.new(**attributes)
        when "1.2", "1.2.0"
          Meibo::JapanProfile::UserM0.new(**attributes)
        end
      end

      transient do
        homeroom { nil }
      end

      home_class { homeroom&.sourced_id }
    end

    trait :eportal do
      id
      jp
      sequence(:preferred_given_name) { |n| "山田#{n}" }
      sequence(:preferred_family_name) { |n| "太郎#{n}" }
      kana_given_name { "ヤマダ" }
      kana_family_name { "タロウ" }
    end
  end
end
