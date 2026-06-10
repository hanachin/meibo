# frozen_string_literal: true

module Meibo
  module PSEInteroperabilityStandard
    module V6
      PROFILE = Profile.new(
        builders: ::Meibo::PSEInteroperabilityStandard::V5::PROFILE.builders.merge(
          enrollment: ::Meibo::Builder::EnrollmentBuilder.create(::Meibo::PSEInteroperabilityStandard::V6::Enrollment)
        ),
        data_models: ::Meibo::PSEInteroperabilityStandard::V5::PROFILE.data_models.merge(
          file_enrollments: ::Meibo::PSEInteroperabilityStandard::V6::Enrollment
        ),
        data_set: ::Meibo::PSEInteroperabilityStandard::V5::PROFILE.data_set,
        manifest_properties: ::Meibo::JapanK12SchoolsProfile::V1::PROFILE.manifest_properties
      )
    end
  end
end
