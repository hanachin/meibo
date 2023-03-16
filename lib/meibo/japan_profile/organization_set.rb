# frozen_string_literal: true

module Meibo
  module JapanProfile
    class OrganizationSet < ::Meibo::OrganizationSet
      def check_semantically_consistent
        super

        each do |organization|
          next unless organization.parent_sourced_id

          next unless organization.district?

          field = organization.parent_sourced_id
          field_info = field_info_from(organization, :parent_sourced_id)
          raise InvalidDataTypeError.new(field: field, field_info: field_info)
        end
      end
    end
  end
end
