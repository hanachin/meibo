# frozen_string_literal: true

module Meibo
  module Eportal
    module V4
      include V3

      PROFILE = Profile.new(
        builders: V3::PROFILE.builders.merge(user: Builder::UserBuilder.create(User)),
        data_models: V3::PROFILE.data_models.merge(file_users: User),
        data_set: V3::PROFILE.data_set,
        manifest_properties: { oneroster_version: "1.2.1" }
      )
    end
  end
end
