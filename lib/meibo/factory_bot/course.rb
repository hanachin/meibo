# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_course, class: 'Meibo::Course' do
    initialize_with { new(**attributes) }

    transient do
      school_year { nil }
      organization { nil }
    end

    sourced_id { SecureRandom.uuid }
    school_year_sourced_id { school_year&.sourced_id }
    title { "#{school_year&.title}ホームルーム" }
    course_code { '' }
    org_sourced_id { organization&.sourced_id }
  end
end
