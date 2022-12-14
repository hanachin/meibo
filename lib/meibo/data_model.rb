# frozen_string_literal: true

require "csv"

module Meibo
  module DataModel
    module ClassMethods
      def parse(csv)
        return to_enum(:parse, csv) unless block_given?

        actual_headers = CSV.parse_line(csv)
        missing_headers = header_fields - actual_headers
        raise MissingHeadersError, "missing headers: #{missing_headers.join(",")}" unless missing_headers.empty?
        raise ScrambledHeadersError unless actual_headers.take(header_fields.size) == header_fields

        CSV.parse(csv, encoding: Meibo::CSV_ENCODING, headers: true, converters: parser_converters,
                       header_converters: header_converters).each do |row|
          yield new(**row.to_h)
        end
      end
    end

    def self.define(klass, attribute_name_to_header_field_map:, converters: {})
      attribute_name_to_header_field_map = attribute_name_to_header_field_map.dup.freeze
      attribute_names = attribute_name_to_header_field_map.keys.freeze
      header_fields = attribute_name_to_header_field_map.values.freeze
      converters = converters.dup.freeze
      define_class_attribute(klass, :attribute_name_to_header_field_map, attribute_name_to_header_field_map)
      define_class_attribute(klass, :attribute_names, attribute_names)
      define_class_attribute(klass, :header_fields, header_fields)
      define_class_attribute(klass, :converters, converters)

      define_header_converters(klass, attribute_name_to_header_field_map)
      define_parser_converters(klass, attribute_names: attribute_names, converters: converters)
      define_write_converters(klass, attribute_names: attribute_names, converters: converters)

      klass.attr_reader(*attribute_names, :extension_fields)
      klass.extend(ClassMethods)
      klass.include(self)
    end

    def self.define_class_attribute(klass, attribute, value)
      klass.define_singleton_method(attribute) { value }
    end

    def self.define_header_converters(klass, attribute_name_to_header_field_map)
      header_converters = Converter.build_header_field_to_attribute_converter(attribute_name_to_header_field_map)
      klass.define_singleton_method(:header_converters) { header_converters }
    end

    def self.define_parser_converters(klass, attribute_names:, converters:)
      parser_converter = Converter.build_parser_converter(fields: attribute_names, converters: converters)
      klass.define_singleton_method(:parser_converters) { parser_converter }
    end

    def self.define_write_converters(klass, attribute_names:, converters:)
      write_converter = Converter.build_write_converter(fields: attribute_names, converters: converters)
      klass.define_singleton_method(:write_converters) { write_converter }
    end

    def lineno
      collection.lineno(self)
    end

    def to_csv(...)
      to_a.to_csv(...)
    end

    def deconstruct
      to_a
    end

    def deconstruct_keys(_keys)
      to_h
    end

    def to_a
      self.class.attribute_names.map { |attribute| public_send(attribute) }
    end

    def to_h
      self.class.attribute_names.zip(to_a).to_h
    end
  end
end
