# frozen_string_literal: true

module Meibo
  module OneRoster
    module V1_2_1
      PROFILE = Profile.new(
        builders: V1_2::PROFILE.builders.merge(
          user: Builder::UserBuilder.create(User)
        ),
        data_models: V1_2::PROFILE.data_models.merge(
          file_users: Meibo::User
        ),
        data_set: V1_2::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2.1" }
      )
    end
  end
end
