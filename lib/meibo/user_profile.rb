# frozen_string_literal: true

module Meibo
  class UserProfile
    include DataModel

    define_attributes(
      sourced_id: "sourcedId",
      status: "status",
      date_last_modified: "dateLastModified",
      user_sourced_id: "userSourcedId",
      profile_type: "profileType",
      vendor_id: "vendorId",
      application_id: "applicationId",
      description: "description",
      credential_type: "credentialType",
      username: "username",
      password: "password"
    )

    define_converters(
      datetime: [:date_last_modified],
      required: %i[sourced_id user_sourced_id profile_type vendor_id credential_type username],
      status: [:status]
    )

    def initialize(sourced_id:, user_sourced_id:, profile_type:, vendor_id:, credential_type:, username:, status: nil, date_last_modified: nil,
                   application_id: nil, description: nil, password: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @user_sourced_id = user_sourced_id
      @profile_type = profile_type
      @vendor_id = vendor_id
      @application_id = application_id
      @description = description
      @credential_type = credential_type
      @username = username
      @password = password
      @extension_fields = extension_fields
    end

    def collection
      Meibo.current_roster.user_profiles
    end

    def user
      Meibo.current_roster.users.find(user_sourced_id)
    end

    def role
      Meibo.current_roster.roles.where(user_profile_sourced_id: sourced_id).first
    end
  end
end
