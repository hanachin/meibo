# frozen_string_literal: true

module Meibo
  class UserProfile
    Data.define(
      self,
      filename: 'userProfile.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        user_sourced_id: 'userSourcedId',
        profile_type: 'profileType',
        vendor_id: 'vendorId',
        application_id: 'applicationId',
        description: 'description',
        credential_type: 'credentialType',
        username: 'username',
        password: 'password'
      }
    )

    def initialize(sourced_id:, user_sourced_id:, profile_type:, vendor_id:, application_id: nil, description: nil, credential_type:, username:, password: nil)
      @sourced_id = sourced_id
      @user_sourced_id = user_sourced_id
      @profile_type = profile_type
      @vendor_id = vendor_id
      @application_id = application_id
      @description = description
      @credential_type = credential_type
      @username = username
      @password = password
    end
  end
end
