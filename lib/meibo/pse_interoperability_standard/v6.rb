# frozen_string_literal: true

module Meibo
  module PSEInteroperabilityStandard
    module V6
      PROFILE = Profile.new(
        builders: V5::PROFILE.builders.merge(
          enrollment: Builder::EnrollmentBuilder.create(::Meibo::PSEInteroperabilityStandard::V6::Enrollment)
        ),
        data_models: V5::PROFILE.data_models.merge(
          file_enrollments: ::Meibo::PSEInteroperabilityStandard::V6::Enrollment
        ),
        data_set: ::Meibo::JapanK12SchoolsProfile::V1::PROFILE.data_set,
        manifest_properties: ::Meibo::JapanK12SchoolsProfile::V1::PROFILE.manifest_properties
      )
    end
  end
end
