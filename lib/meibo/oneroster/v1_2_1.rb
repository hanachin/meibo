# frozen_string_literal: true

module Meibo
  module OneRoster
    module V1_2_1
      include V1_2

      User = ::Meibo::User

      PROFILE = Profile.new(
        builders: ::Meibo::OneRoster::V1_2::PROFILE.builders.merge(
          user: ::Meibo::Builder::UserBuilder.create(User)
        ),
        data_models: ::Meibo::OneRoster::V1_2::PROFILE.data_models.merge(
          file_users: ::Meibo::User
        ),
        data_set: ::Meibo::OneRoster::V1_2::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2.1" }
      )
    end
  end
end
