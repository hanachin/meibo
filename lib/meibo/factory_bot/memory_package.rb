# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :meibo_memory_package, class: 'Meibo::MemoryPackage' do
    initialize_with { new(**attributes) }

    manifest { build(:meibo_manifest) }
  end
end
