# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_2
      include ::Meibo::OneRoster::V1_2_1

      PROFILE = Profile.new(
        builders: ::Meibo::JapanProfile::V1_1::PROFILE.builders.merge(
          user: ::Meibo::Builder::UserBuilder.create(::Meibo::JapanProfile::V1_2::User)
        ),
        data_models: ::Meibo::JapanProfile::V1_1::PROFILE.data_models.merge(
          file_users: ::Meibo::JapanProfile::V1_2::User
        ),
        data_set: ::Meibo::JapanProfile::V1_1::PROFILE.data_set,
        manifest_properties: ::Meibo::JapanProfile::V1_1::PROFILE.manifest_properties
      )
    end
  end
end
