# frozen_string_literal: true

module Meibo
  module JapanK12SchoolsProfile
    module V1
      PROFILE = Profile.new(
        builders: JapanProfile::V1_2::PROFILE.builders.merge(enrollment: Builder::EnrollmentBuilder.create(Enrollment)),
        data_models: JapanProfile::V1_2::PROFILE.data_models.merge(file_enrollments: Enrollment),
        data_set: JapanProfile::V1_2::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2_JP" }
      )
    end
  end
end
