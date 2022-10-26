# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_academic_session, class: 'Meibo::AcademicSession' do
    initialize_with { new(**attributes) }

    transient do
      today { Date.today }
      parent { nil }
    end

    sourced_id { SecureRandom.uuid }
    title { "#{school_year}年度" }
    type { Meibo::AcademicSession::TYPES[:school_year] }
    start_date { Date.new(school_year, 4, 1).iso8601 }
    end_date { Date.new(school_year + 1, 3, 31).iso8601 }
    parent_sourced_id { parent&.sourced_id }
    school_year { today.year }
  end
end
