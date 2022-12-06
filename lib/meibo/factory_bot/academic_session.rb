# frozen_string_literal: true

require "factory_bot"
require "securerandom"

FactoryBot.define do
  factory :meibo_academic_session, class: "Meibo::AcademicSession" do
    initialize_with { new(**attributes) }

    transient do
      today { Date.today }
      parent { nil }
    end

    sourced_id { SecureRandom.uuid }
    title { "#{school_year}年度" }
    type { Meibo::AcademicSession::TYPES[:school_year] }
    start_date { Date.new(school_year, 4, 1) }
    end_date { Date.new(school_year + 1, 3, 31) }
    parent_sourced_id { parent&.sourced_id }
    school_year { today.year }

    trait :grading_period do
      type { Meibo::AcademicSession::TYPES[:grading_period] }
    end

    trait :semester do
      type { Meibo::AcademicSession::TYPES[:semester] }
    end

    trait :school_year do
      type { Meibo::AcademicSession::TYPES[:school_year] }
    end

    trait :term do
      type { Meibo::AcademicSession::TYPES[:term] }
    end

    trait :jp do
      initialize_with { Meibo::JapanProfile::AcademicSession.new(**attributes) }
    end
  end
end
