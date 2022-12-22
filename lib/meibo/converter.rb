# frozen_string_literal: true

require "date"
require "time"

module Meibo
  module Converter
    # @type var types: ::Meibo::Converter::converter_types
    types = %i[
      list
      required
      boolean
      date
      datetime
      enum
      integer
      status
      user_ids
      year
    ]
    types.freeze
    TYPES = types

    class << self
      def build_header_field_to_attribute_converter(attribute_name_to_header_field_map)
        header_field_to_attribute_name_map = attribute_name_to_header_field_map.to_h do |attribute, header_field|
          [header_field, attribute]
        end.freeze
        ->(field) { header_field_to_attribute_name_map.fetch(field, field) }
      end

      def build_parser_converter(fields:, converters:)
        build_converter(fields: fields, converters: converters, write_or_parser: "parser")
      end

      def build_write_converter(fields:, converters:)
        build_converter(fields: fields, converters: converters, write_or_parser: "write")
      end

      private

      def build_converter(fields:, converters:, write_or_parser:)
        converter_list = TYPES.filter_map do |converter_type|
          fields_to_be_converted = converters[converter_type]
          method_name = "build_#{converter_type}_field_#{write_or_parser}_converter"
          if fields_to_be_converted && respond_to?(method_name, true)
            if converter_type == :enum
              enum_definition = fields_to_be_converted.transform_keys { |field| fields.index(field) }
              send(method_name, enum_definition)
            else
              indexes = fields_to_be_converted.map { |field| fields.index(field) }
              send(method_name, indexes)
            end
          end
        end
        lambda do |field, field_info|
          # NOTE: convert blank sourcedId to nil
          field = nil if field_info.index.zero? && field.empty?
          converter_list.each { |converter| field = converter[field, field_info] }
          field
        end
      end

      def build_boolean_field_parser_converter(boolean_field_indexes)
        boolean_field_indexes = boolean_field_indexes.dup.freeze
        lambda do |field, field_info|
          if boolean_field_indexes.include?(field_info.index)
            case field
            when "true"
              true
            when "false"
              false
            when nil
              nil
            else
              raise InvalidDataTypeError
            end
          else
            field
          end
        end
      end

      def build_date_field_write_converter(date_field_indexes)
        date_field_indexes = date_field_indexes.dup.freeze
        lambda do |field, field_info|
          if date_field_indexes.include?(field_info.index)
            field&.iso8601
          else
            field
          end
        end
      end

      def build_date_field_parser_converter(date_field_indexes)
        date_field_indexes = date_field_indexes.dup.freeze
        lambda do |field, field_info|
          if field && date_field_indexes.include?(field_info.index)
            begin
              Date.strptime(field.to_s, "%Y-%m-%d")
            rescue StandardError
              raise InvalidDataTypeError
            end
          else
            field
          end
        end
      end

      def build_datetime_field_write_converter(datetime_field_indexes)
        datetime_field_indexes = datetime_field_indexes.dup.freeze
        lambda do |field, field_info|
          if datetime_field_indexes.include?(field_info.index)
            field&.utc&.iso8601
          else
            field
          end
        end
      end

      def build_datetime_field_parser_converter(datetime_field_indexes)
        datetime_field_indexes = datetime_field_indexes.dup.freeze
        lambda do |field, field_info|
          if field && datetime_field_indexes.include?(field_info.index)
            begin
              Time.iso8601(field.to_s)
            rescue StandardError
              raise InvalidDataTypeError
            end
          else
            field
          end
        end
      end

      def build_enum_field_parser_converter(enum_definition)
        enum_definition = enum_definition.dup.freeze
        lambda do |field, field_info|
          return field unless field

          enum = enum_definition[field_info.index]
          raise InvalidDataTypeError if enum&.none? { |e| e.match?(field) }

          field
        end
      end

      def build_integer_field_parser_converter(integer_field_indexes)
        integer_field_indexes = integer_field_indexes.dup.freeze
        lambda do |field, field_info|
          if field && integer_field_indexes.include?(field_info.index)
            begin
              Integer(field.to_s, 10)
            rescue StandardError
              raise InvalidDataTypeError
            end
          else
            field
          end
        end
      end

      def build_list_field_write_converter(list_field_indexes)
        list_field_indexes = list_field_indexes.dup.freeze
        lambda do |field, field_info|
          if list_field_indexes.include?(field_info.index)
            if field
              if field.empty?
                nil
              else
                field.join(",")
              end
            end
          else
            field
          end
        end
      end

      def build_list_field_parser_converter(list_field_indexes)
        list_field_indexes = list_field_indexes.dup.freeze
        lambda do |field, field_info|
          if list_field_indexes.include?(field_info.index)
            if field
              field.split(",").map(&:strip)
            else
              []
            end
          else
            field
          end
        end
      end

      def build_required_field_parser_converter(required_field_indexes)
        required_field_indexes = required_field_indexes.dup.freeze
        lambda do |field, field_info|
          if required_field_indexes.include?(field_info.index)
            raise MissingDataError if field.nil?
            raise MissingDataError if field.respond_to?(:empty?) && field.empty?
          end
          field
        end
      end

      # TODO
      # def build_role_field_write_converter(role_field_indexes)

      def build_status_field_parser_converter(status_field_indexes)
        status_field_indexes = status_field_indexes.dup.freeze
        lambda do |field, field_info|
          if field && status_field_indexes.include?(field_info.index)
            raise InvalidDataTypeError, "invalid status: #{field}" unless %w[active tobedeleted].include?(field.to_s)
          else
            field
          end
        end
      end

      def build_user_ids_field_parser_converter(user_ids_field_indexes)
        user_ids_field_indexes = user_ids_field_indexes.dup.freeze
        lambda do |field, field_info|
          if user_ids_field_indexes.include?(field_info.index) && !field.all? do |user_id|
               Meibo::User::USER_ID_FORMAT_REGEXP.match?(user_id)
             end
            raise InvalidDataTypeError
          end

          field
        end
      end

      def build_year_field_write_converter(year_field_indexes)
        year_field_indexes = year_field_indexes.dup.freeze
        lambda do |field, field_info|
          if year_field_indexes.include?(field_info.index)
            field && ("%04d" % field)
          else
            field
          end
        end
      end

      def build_year_field_parser_converter(year_field_indexes)
        year_field_indexes = year_field_indexes.dup.freeze
        lambda do |field, field_info|
          if field && year_field_indexes.include?(field_info.index)
            begin
              Integer(field.to_s, 10)
            rescue StandardError
              raise InvalidDataTypeError
            end
          else
            field
          end
        end
      end
    end
  end
end
