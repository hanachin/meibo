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
    special_needs { false }

    trait :special_needs do
      special_needs { true }
    end
  end
end
