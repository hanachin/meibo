# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_classroom, class: 'Meibo::Classroom' do
    initialize_with { new(**attributes) }

    transient do
      course { nil }
      school { nil }
      terms { [] }
    end

    sourced_id { SecureRandom.uuid }
    sequence(:title) {|n| "#{n}組" }
    course_sourced_id { course&.sourced_id }
    class_type { Meibo::Classroom::TYPES[:homeroom] }
    school_sourced_id { school&.sourced_id }
    term_sourced_ids { terms.map(&:sourced_id) }

    trait :homeroom do
      class_type { Meibo::Classroom::TYPES[:homeroom] }
    end

    trait :scheduled do
      class_type { Meibo::Classroom::TYPES[:scheduled] }
    end

    trait :jp do
      initialize_with { Meibo::JapanProfile::Classroom.new(**attributes) }
    end

    trait :special_needs do
      special_needs { true }
    end

    trait :no_special_needs do
      special_needs { false }
    end
  end
end
