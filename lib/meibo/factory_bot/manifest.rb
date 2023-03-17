# frozen_string_literal: true

require "factory_bot"

FactoryBot.define do
  factory :meibo_manifest, class: "Meibo::Manifest" do
    initialize_with { new(**attributes) }

    manifest_version { Meibo::Manifest::EXPECTED_VALUES[:manifest_version] }
    oneroster_version { Meibo::Manifest::EXPECTED_VALUES[:oneroster_version] }
  end
end
