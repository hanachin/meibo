# frozen_string_literal: true

require "csv"

module Meibo
  module DataModel
    module ClassMethods
      def define_attributes(attribute_names_to_header_fields)
        attribute_names_to_header_fields = attribute_names_to_header_fields.dup.freeze
        attribute_names = attribute_names_to_header_fields.keys.freeze
        header_fields = attribute_names_to_header_fields.values.freeze
        define_class_attribute(:attribute_names_to_header_fields, attribute_names_to_header_fields)
        define_class_attribute(:attribute_names, attribute_names)
        define_class_attribute(:header_fields, header_fields)

        attr_reader(*attribute_names, :extension_fields)
      end

      def define_converters(converters)
        converters = converters.dup.freeze
        define_class_attribute(:converters, converters)
        define_header_converters
        define_parser_converters(converters)
        define_write_converters(converters)
      end

      def parse(csv)
        return to_enum(:parse, csv) unless block_given?

        _parse(csv) do |row|
          yield new(**row.to_h)
        end
      end

      def validate_header_fields(actual_header_fields)
        missing_header_fields = header_fields - actual_header_fields
        unless missing_header_fields.empty?
          message = "missing header fields: #{missing_header_fields.join(",")}"
          raise MissingHeaderFieldsError.new(message, missing_header_fields: missing_header_fields)
        end
        raise ScrambledHeaderFieldsError unless actual_header_fields.take(header_fields.size) == header_fields
      end

      private

      def _parse(csv, &block)
        validate_header_fields(CSV.parse_line(csv))

        CSV.parse(csv, encoding: Meibo::CSV_ENCODING, headers: true, converters: parser_converters, header_converters: header_converters).each(&block)
      end

      def define_class_attribute(attribute, value)
        define_singleton_method(attribute) { value }
      end

      def define_header_converters
        header_converters = Converter.build_header_field_to_attribute_converter(attribute_names_to_header_fields)
        define_class_attribute(:header_converters, header_converters)
      end

      def define_parser_converters(converters)
        parser_converter = Converter.build_parser_converter(fields: attribute_names, converters: converters)
        define_class_attribute(:parser_converters, parser_converter)
      end

      def define_write_converters(converters)
        write_converter = Converter.build_write_converter(fields: attribute_names, converters: converters)
        define_class_attribute(:write_converters, write_converter)
      end
    end

    def self.included(base)
      super
      base.extend(ClassMethods)
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
