# frozen_string_literal: true

module Meibo
  class User
    Data.define(
      self,
      filename: 'users.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        enabled_user: 'enabledUser',
        username: 'username',
        user_ids: 'userIds',
        given_name: 'givenName',
        family_name: 'familyName',
        middle_name: 'middleName',
        identifier: 'identifier',
        email: 'email',
        sms: 'sms',
        phone: 'phone',
        agent_sourced_ids: 'agentSourcedIds',
        grades: 'grades',
        password: 'password',
        user_master_identifier: 'userMasterIdenfitier',
        resource_sourced_ids: 'resourceSourcedIds',
        preferred_given_name: 'preferredGivenName',
        preferred_middle_name: 'preferredMiddleName',
        preferred_family_name: 'preferredFamilyName',
        primary_org_sourced_id: 'primaryOrgSourcedId',
        kana_given_name: 'metadata.jp.kanaGivenName',
        kana_family_name: 'metadata.jp.kanaFamilyName',
        kana_middle_name: 'metadata.jp.kanaMiddleName',
        home_class: 'metadata.jp.homeClass'
      },
      converters: {
        list: [:user_ids, :agent_sourced_ids, :grades, :resource_sourced_ids]
      }
    )

    # NOTE: enabled_userは必須ではないが固定
    def initialize(sourced_id:, enabled_user: true, username:, user_ids: nil, given_name:, family_name:, middle_name: nil, identifier: nil, email: nil, sms: nil, phone: nil, agent_sourced_ids: nil, grades: nil, password: nil, user_master_identifier: nil, resource_sourced_ids: nil, preferred_given_name: nil, preferred_middle_name: nil, preferred_family_name: nil, primary_org_sourced_id: nil, kana_given_name: nil, kana_family_name: nil, kana_middle_name: nil, home_class: nil)
      @sourced_id = sourced_id
      @enabled_user = enabled_user
      @username = username
      @user_ids = user_ids
      @given_name = given_name
      @family_name = family_name
      @middle_name = middle_name
      @identifier = identifier
      @email = email
      @sms = sms
      @phone = phone
      @agent_sourced_ids = agent_sourced_ids
      @grades = grades
      @password = password
      @user_master_identifier = user_master_identifier
      @resource_sourced_ids = resource_sourced_ids
      @preferred_given_name = preferred_given_name
      @preferred_middle_name = preferred_middle_name
      @preferred_family_name = preferred_family_name
      @primary_org_sourced_id = primary_org_sourced_id
      @kana_given_name = kana_given_name
      @kana_family_name = kana_family_name
      @kana_middle_name = kana_middle_name
      @home_class = home_class
    end
  end
end
