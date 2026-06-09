# frozen_string_literal: true

module Meibo
  module Eportal
    module V4
      include ::Meibo::Eportal::V3

      PROFILE = Profile.new(
        builders: ::Meibo::Eportal::V3::PROFILE.builders.merge(user: Builder::UserBuilder.create(::Meibo::Eportal::V4::User)),
        data_models: ::Meibo::Eportal::V3::PROFILE.data_models.merge(file_users: ::Meibo::Eportal::V4::User),
        data_set: ::Meibo::Eportal::V3::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2.1" }
      )
    end
  end
end
