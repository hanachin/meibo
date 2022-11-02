# frozen_string_literal: true

module Meibo
  class Organization
    DataModel.define(
      self,
      filename: 'orgs.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        name: 'name',
        type: 'type',
        identifier: 'identifier',
        parent_sourced_id: 'parentSourcedId'
      },
      converters: {
        datetime: [:date_last_modified],
        org_type: [:type],
        required: [:sourced_id, :name, :type],
        status: [:status]
      }
    )

    TYPES = {
      district: 'district',
      school: 'school'
    }.freeze

    def initialize(sourced_id:, status: nil, date_last_modified: nil, name:, type:, identifier: nil, parent_sourced_id: (type == TYPES[:district] ? 'NULL' : nil), **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @name = name
      @type = type
      @identifier = identifier
      @parent_sourced_id = parent_sourced_id
      @extension_fields = extension_fields
    end
  end
end
