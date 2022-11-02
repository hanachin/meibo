# frozen_string_literal: true

module Meibo
  class UserProfile
    DataModel.define(
      self,
      filename: 'userProfiles.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        user_sourced_id: 'userSourcedId',
        profile_type: 'profileType',
        vendor_id: 'vendorId',
        application_id: 'applicationId',
        description: 'description',
        credential_type: 'credentialType',
        username: 'username',
        password: 'password'
      },
      converters: {
        datetime: [:date_last_modified],
        status: [:status]
      },
      validation: {
        required: [:sourced_id, :user_sourced_id, :profile_type, :vendor_id, :credential_type, :username]
      }
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, user_sourced_id:, profile_type:, vendor_id:, application_id: nil, description: nil, credential_type:, username:, password: nil)
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
    end
  end
end
