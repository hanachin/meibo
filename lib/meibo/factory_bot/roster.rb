# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :meibo_roster, class: "Meibo::Roster" do
    initialize_with { new(**attributes) }
  end
end
