# frozen_string_literal: true

module Meibo
  module JapanK12SchoolsProfile
    module V1
      include ::Meibo::JapanProfile::V1_2

      PROFILE = Profile.new(
        builders: ::Meibo::JapanProfile::V1_2::PROFILE.builders.merge(
          enrollment: ::Meibo::Builder::EnrollmentBuilder.create(::Meibo::JapanK12SchoolsProfile::V1::Enrollment)
        ),
        data_models: ::Meibo::JapanProfile::V1_2::PROFILE.data_models.merge(
          file_enrollments: ::Meibo::JapanK12SchoolsProfile::V1::Enrollment
        ),
        data_set: ::Meibo::JapanProfile::V1_2::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2_JP" }
      )
    end
  end
end
