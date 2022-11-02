# frozen_string_literal: true

require 'date'
require 'time'

module Meibo
  module Converter
    TYPES = [:boolean, :date, :datetime, :integer, :list, :required, :status, :year].freeze

    class << self
      def build_header_field_to_attribute_converter(attribute_name_to_header_field_map)
        header_field_to_attribute_name_map = attribute_name_to_header_field_map.to_h {|attribute, header_field|
          [header_field, attribute]
        }.freeze
        lambda {|field| header_field_to_attribute_name_map.fetch(field) }
      end

      def build_parser_converter(fields:, converters:)
        build_converter(fields: fields, converters: converters, write_or_parser: 'parser')
      end

      def build_write_converter(fields:, converters:)
        build_converter(fields: fields, converters: converters, write_or_parser: 'write')
      end

      private

      def build_converter(fields:, converters:, write_or_parser:)
        converter_list = TYPES.filter_map do |converter_type|
          fields_to_be_converted = converters[converter_type]
          if fields_to_be_converted
            indexes = fields_to_be_converted.map {|field| fields.index(field) }
            send("build_#{converter_type}_field_#{write_or_parser}_converter", indexes)
          end
        end
        lambda do |field, field_info|
          # NOTE: convert blank sourcedId to nil
          if field_info.index.zero?
            field = nil if field.empty?
          end
          converter_list.each {|converter| field = converter[field, field_info] }
          field
        rescue
          raise Meibo::InvalidDataTypeError
        end
      end

      def build_boolean_field_write_converter(boolean_field_indexes)
        boolean_field_indexes = boolean_field_indexes.dup.freeze
        lambda do |field, field_info|
          if boolean_field_indexes.include?(field_info.index)
            field&.to_s
          else
            field
          end
        end
      end

      def build_boolean_field_parser_converter(boolean_field_indexes)
        boolean_field_indexes = boolean_field_indexes.dup.freeze
        lambda do |field, field_info|
          if boolean_field_indexes.include?(field_info.index)
            field && field == 'true'
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
          if date_field_indexes.include?(field_info.index)
            field && Date.strptime(field, '%Y-%m-%d')
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
          if datetime_field_indexes.include?(field_info.index)
            field && Time.iso8601(field)
          else
            field
          end
        end
      end

      def build_integer_field_write_converter(integer_field_indexes)
        lambda {|field, _field_info| field }
      end

      def build_integer_field_parser_converter(integer_field_indexes)
        integer_field_indexes = integer_field_indexes.dup.freeze
        lambda do |field, field_info|
          if integer_field_indexes.include?(field_info.index)
            field && Integer(field, 10)
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
                field.join(',')
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
              field.split(',').map(&:strip)
            else
              []
            end
          else
            field
          end
        end
      end

      def build_required_field_write_converter(required_field_indexes)
        required_field_indexes = required_field_indexes.dup.freeze
        lambda do |field, field_info|
          if required_field_indexes.include?(field_info.index)
            field&.to_s
          else
            field
          end
        end
      end

      def build_required_field_parser_converter(required_field_indexes)
        required_field_indexes = required_field_indexes.dup.freeze
        lambda do |field, field_info|
          if required_field_indexes.include?(field_info.index)
            raise if field.nil?
            raise if field.respond_to?(:empty?) && field.empty?
          end
          field
        end
      end


      def build_status_field_write_converter(status_field_indexes)
        status_field_indexes = status_field_indexes.dup.freeze
        lambda do |field, field_info|
          if status_field_indexes.include?(field_info.index)
            field&.to_s
          else
            field
          end
        end
      end

      def build_status_field_parser_converter(status_field_indexes)
        status_field_indexes = status_field_indexes.dup.freeze
        lambda do |field, field_info|
          if status_field_indexes.include?(field_info.index)
            raise unless field.nil? || field == 'active' || field == 'tobedeleted'
          else
            field
          end
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
          if year_field_indexes.include?(field_info.index)
            field && Integer(field, 10)
          else
            field
          end
        end
      end
    end
  end
end