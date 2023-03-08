# frozen_string_literal: true

module Meibo
  module JapanProfile
    class OrganizationSet < DataSet
      def check_semantically_consistent
        super

        each do |organization|
          next unless organization.parent_sourced_id

          raise InvalidDataTypeError if organization.district?
        end
      end
    end
  end
end
