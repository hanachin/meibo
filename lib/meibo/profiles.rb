# frozen_string_literal: true

module Meibo
  module Profiles
    PROFILES = {
      "v1.2" => OneRoster::V1_2::PROFILE,
      "v1.2.1" => OneRoster::V1_2_1::PROFILE,
      "v1.2 ep v3.00" => Eportal::V3::PROFILE,
      "v1.2 jp v1.1" => JapanProfile::V1_1::PROFILE,
      "v1.2 jp v1.1.1" => JapanProfile::V1_1_1::PROFILE,
      "v1.2.1 jp v1.2" => JapanProfile::V1_2::PROFILE,
      "v1.2.1 ep v4.00" => Meibo::Eportal::V4::PROFILE
    }.freeze

    def self.use(profile_name, &)
      Meibo.with_profile(self[profile_name], &)
    end

    def self.[](profile_name)
      PROFILES.fetch(profile_name)
    end
  end
end
