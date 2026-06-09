# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_2
      PROFILE = Profile.new(
        builders: V1_1::PROFILE.builders.merge(user: Builder::UserBuilder.create(::Meibo::JapanProfile::User)),
        data_models: V1_1::PROFILE.data_models.merge(file_users: ::Meibo::JapanProfile::User),
        data_set: V1_1::PROFILE.data_set,
        manifest_properties: V1_1::PROFILE.manifest_properties
      )
    end
  end
end
