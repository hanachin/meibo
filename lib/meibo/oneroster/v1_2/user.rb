# frozen_string_literal: true

module Meibo
  module OneRoster
    module V1_2
      class User < ::Meibo::User
        define_attributes(
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
        )

        define_converters(superclass.converters.merge(list: [*superclass.converters[:list], :resource_sourced_ids].freeze))

        # NOTE: enabled_userは必須ではないが固定
        def initialize(resource_sourced_ids: nil, **other_fields)
          super(**other_fields)
          @resource_sourced_ids = resource_sourced_ids
        end
      end
    end
  end
end
