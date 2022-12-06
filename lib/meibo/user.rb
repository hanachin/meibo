# frozen_string_literal: true

module Meibo
  class User
    USER_ID_FORMAT_REGEXP = /\A\{[^:}]+:[^}]+\}\z/

    DataModel.define(
      self,
      attribute_name_to_header_field_map: {
        sourced_id: "sourcedId",
        status: "status",
        date_last_modified: "dateLastModified",
        enabled_user: "enabledUser",
        username: "username",
        user_ids: "userIds",
        given_name: "givenName",
        family_name: "familyName",
        middle_name: "middleName",
        identifier: "identifier",
        email: "email",
        sms: "sms",
        phone: "phone",
        agent_sourced_ids: "agentSourcedIds",
        grades: "grades",
        password: "password",
        user_master_identifier: "userMasterIdentifier",
        resource_sourced_ids: "resourceSourcedIds",
        preferred_given_name: "preferredGivenName",
        preferred_middle_name: "preferredMiddleName",
        preferred_family_name: "preferredFamilyName",
        primary_org_sourced_id: "primaryOrgSourcedId",
        pronouns: "pronouns"
      }.freeze,
      converters: {
        boolean: [:enabled_user].freeze,
        datetime: [:date_last_modified].freeze,
        list: %i[user_ids agent_sourced_ids grades resource_sourced_ids].freeze,
        required: %i[sourced_id enabled_user username given_name family_name].freeze,
        status: [:status].freeze,
        user_ids: [:user_ids].freeze
      }.freeze
    )

    def initialize(sourced_id:, username:, given_name:, family_name:, status: nil, date_last_modified: nil,
                   enabled_user: nil, user_ids: nil, middle_name: nil, identifier: nil, email: nil, sms: nil, phone: nil, agent_sourced_ids: [], grades: nil, password: nil, user_master_identifier: nil, resource_sourced_ids: nil, preferred_given_name: nil, preferred_middle_name: nil, preferred_family_name: nil, primary_org_sourced_id: nil, pronouns: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
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
      @pronouns = pronouns
      @extension_fields = extension_fields
    end

    def collection
      Meibo.current_roster.users
    end

    def agents
      agent_sourced_ids.map { |agent_sourced_id| Meibo.current_roster.users.find(agent_sourced_id) }
    end

    def demographic
      Meibo.current_roster.demographics.find(sourced_id)
    rescue DataNotFoundError
      nil
    end

    def enrollments
      Meibo.current_roster.enrollments.where(user_sourced_id: sourced_id)
    end

    def primary_organization
      primary_org_sourced_id && Meibo.current_roster.organizations.find(primary_org_sourced_id)
    end

    def primary_role_in(org)
      Meibo.current_roster.roles.where(user_sourced_id: sourced_id).detect do |role|
        role.primary? && role.org_sourced_id == org.sourced_id
      end
    end

    def roles
      Meibo.current_roster.roles.where(user_sourced_id: sourced_id)
    end

    def user_profiles
      Meibo.current_roster.user_profiles.where(user_sourced_id: sourced_id)
    end
  end
end
