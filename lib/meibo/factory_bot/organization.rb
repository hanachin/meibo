# frozen_string_literal: true

require "factory_bot"
require "securerandom"

FactoryBot.define do
  factory :meibo_organization, class: "Meibo::Organization" do
    initialize_with { new(**attributes) }

    transient do
      parent { nil }

      # NOTE: https://www.mext.go.jp/content/20210128-mxt_chousa01-000011635_01.pdf
      school_type { "B1" } # 小学校
      prefecture_no { "01" } # 北海道
      kubun { "2" } # 公立
      sequence(:school_no) { |n| "%07d" % n }
    end

    sourced_id { SecureRandom.uuid }
    parent_sourced_id { parent&.sourced_id }
    identifier do
      school_type_alphabet_map = { "A" => "01", "B" => "02", "C" => "03", "D" => "04", "E" => "05", "F" => "06",
                                   "G" => "07", "H" => "08" }.freeze
      numerized_school_type = school_type.sub(/\A[A-H]/, school_type_alphabet_map)
      numerized_school_code = "#{numerized_school_type}#{prefecture_no}#{kubun}#{school_no}"

      raise unless numerized_school_code.size == 13

      check_digit = (10 - (numerized_school_code.chars.map(&:to_i).zip([1, 2].cycle).map do
                             (_1 * _2).digits.sum
                           end.sum % 10)) % 10
      "#{school_type}#{prefecture_no}#{kubun}#{school_no}#{check_digit}"
    end

    trait :department do
      type { Meibo::Organization::TYPES[:department] }
    end

    trait :school do
      type { Meibo::Organization::TYPES[:school] }
    end

    trait :district do
      type { Meibo::Organization::TYPES[:district] }
    end

    trait :local do
      type { Meibo::Organization::TYPES[:local] }
    end

    trait :state do
      type { Meibo::Organization::TYPES[:state] }
    end

    trait :national do
      type { Meibo::Organization::TYPES[:national] }
    end

    trait :elementary_school do |_factory|
      type { Meibo::Organization::TYPES[:school] }
      sequence(:name) { |n| "第#{n}小学校" }
      school_type { "B1" }
    end

    trait :jp do
      initialize_with { Meibo::JapanProfile::Organization.new(**attributes) }
    end
  end
end
