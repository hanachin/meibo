# frozen_string_literal: true

module Meibo
  class Organization
    TYPES = {
      department: 'department',
      school: 'school',
      district: 'district',
      local: 'local',
      state: 'state',
      national: 'national'
    }.freeze

    DataModel.define(
      self,
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
        enum: { type: [*TYPES.values, ENUM_EXT_PATTERN].freeze },
        required: [:sourced_id, :name, :type],
        status: [:status]
      }
    )

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

    def department?
      type == TYPES[:department]
    end

    def school?
      type == TYPES[:school]
    end

    def district?
      type == TYPES[:district]
    end

    def local?
      type == TYPES[:local]
    end

    def state?
      type == TYPES[:state]
    end

    def national?
      type == TYPES[:national]
    end

    def parent
      parent_sourced_id && Meibo.current_roster.organizations.find(parent_sourced_id)
    end

    def enrollments
      Meibo.current_roster.enrollments.where(school_sourced_id: sourced_id)
    end

    def classes
      Meibo.current_roster.classes.where(school_sourced_id: sourced_id)
    end

    def courses
      Meibo.current_roster.courses.where(org_sourced_id: sourced_id)
    end

    def roles
      Meibo.current_roster.roles.where(org_sourced_id: sourced_id)
    end
  end
end
