# frozen_string_literal: true

require 'date'

module Meibo
  module Converter
    def self.build_header_field_to_attribute_converter(attribute_name_to_header_field_map)
      header_field_to_attribute_name_map = attribute_name_to_header_field_map.to_h {|attribute, header_field|
        [header_field, attribute]
      }.freeze
      lambda {|field| header_field_to_attribute_name_map.fetch(field) }
    end

    def self.build_boolean_field_converters(...)
      {
        write_converter: build_boolean_field_write_converter(...),
        parser_converter: build_boolean_field_parser_converter(...)
      }
    end

    def self.build_date_field_converters(...)
      {
        write_converter: build_date_field_write_converter(...),
        parser_converter: build_date_field_parser_converter(...)
      }
    end

    def self.build_integer_field_converters(...)
      {
        write_converter: build_integer_field_write_converter(...),
        parser_converter: build_integer_field_parser_converter(...)
      }
    end

    def self.build_list_field_converters(...)
      {
        write_converter: build_list_field_write_converter(...),
        parser_converter: build_list_field_parser_converter(...)
      }
    end

    def self.build_year_field_converters(...)
      {
        write_converter: build_year_field_write_converter(...),
        parser_converter: build_year_field_parser_converter(...)
      }
    end

    def self.build_boolean_field_write_converter(boolean_field_indexes)
      boolean_field_indexes = boolean_field_indexes.dup.freeze
      lambda do |field, field_info|
        if boolean_field_indexes.include?(field_info.index)
          field&.to_s
        else
          field
        end
      end
    end

    def self.build_boolean_field_parser_converter(boolean_field_indexes)
      boolean_field_indexes = boolean_field_indexes.dup.freeze
      lambda do |field, field_info|
        if boolean_field_indexes.include?(field_info.index)
          field && field == 'true'
        else
          field
        end
      end
    end

    def self.build_date_field_write_converter(date_field_indexes)
      date_field_indexes = date_field_indexes.dup.freeze
      lambda do |field, field_info|
        if date_field_indexes.include?(field_info.index)
          field&.iso8601
        else
          field
        end
      end
    end

    def self.build_date_field_parser_converter(date_field_indexes)
      date_field_indexes = date_field_indexes.dup.freeze
      lambda do |field, field_info|
        if date_field_indexes.include?(field_info.index)
          field && Date.iso8601(field)
        else
          field
        end
      end
    end

    def self.build_integer_field_write_converter(integer_field_indexes)
      lambda {|field, _field_info| field }
    end

    def self.build_integer_field_parser_converter(integer_field_indexes)
      integer_field_indexes = integer_field_indexes.dup.freeze
      lambda do |field, field_info|
        if integer_field_indexes.include?(field_info.index)
          field && Integer(field, 10)
        else
          field
        end
      end
    end

    def self.build_list_field_write_converter(list_field_indexes)
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

    def self.build_list_field_parser_converter(list_field_indexes)
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

    def self.build_year_field_write_converter(year_field_indexes)
      year_field_indexes = year_field_indexes.dup.freeze
      lambda do |field, field_info|
        if year_field_indexes.include?(field_info.index)
          field && ("%04d" % field)
        else
          field
        end
      end
    end

    def self.build_year_field_parser_converter(year_field_indexes)
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
