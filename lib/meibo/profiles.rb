# frozen_string_literal: true

module Meibo
  module Profiles
    PROFILES = {
      "IMS OneRoster: CSV Binding Final Release v1.2" => OneRoster::V1_2::PROFILE,
      "IMS OneRoster: CSV Binding Final Release v1.2.1" => OneRoster::V1_2_1::PROFILE,
      "学習eポータル標準モデル Ver. 3.00" => Eportal::V3::PROFILE,
      "OneRoster Japan Profile 第2版" => JapanProfile::V1_1::PROFILE,
      "OneRoster Japan Profile 第2版 (rev.2)" => JapanProfile::V1_1_1::PROFILE,
      "OneRoster Japan Profile v.1.2.1" => JapanProfile::V1_2::PROFILE,
      "学習eポータル標準モデル Ver. 4.00" => Meibo::Eportal::V4::PROFILE,
      "初等中等教育におけるシステム間連携のための相互運用標準モデル Ver. 5.00" => Meibo::PSEInteroperabilityStandard::V5::PROFILE,
      "1EdTech OneRoster 1.2 CSV Binding: Japan K-12/Schools Profile" => JapanK12SchoolsProfile::V1::PROFILE,
      "初等中等教育におけるシステム間連携のための相互運用標準モデル Ver. 6.00" => Meibo::PSEInteroperabilityStandard::V6::PROFILE
    }.freeze

    def self.use(profile_name, &)
      Meibo.with_profile(self[profile_name], &)
    end

    def self.[](profile_name)
      PROFILES.fetch(profile_name)
    end
  end
end
