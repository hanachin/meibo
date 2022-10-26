# frozen_string_literal: true

require 'csv'

module Meibo
  module Data
    module ClassMethods
      def parse(csv)
        CSV.parse(csv, encoding: Meibo::CSV_ENCODING, headers: true, converters: parser_converters, header_converters: header_converters).each do |row|
          yield new(**row.to_h)
        end
      end
    end

    def self.define(klass, attribute_name_to_header_field_map:, filename:, converters: {})
      klass.define_singleton_method(:filename) { filename }

      attribute_names = attribute_name_to_header_field_map.keys.freeze
      header_fields = attribute_name_to_header_field_map.values.freeze
      klass.define_singleton_method(:attribute_names) { attribute_names } 
      klass.define_singleton_method(:header_fields) { header_fields } 

      converters_list = []
      if converters[:boolean]
        converters_list << Converter.build_boolean_field_converters(converters[:boolean].map {|field| attribute_names.index(field) })
      end
      if converters[:date]
        converters_list << Converter.build_date_field_converters(converters[:date].map {|field| attribute_names.index(field) })
      end
      if converters[:integer]
        converters_list << Converter.build_integer_field_converters(converters[:integer].map {|field| attribute_names.index(field) })
      end
      if converters[:list]
        converters_list << Converter.build_list_field_converters(converters[:list].map {|field| attribute_names.index(field) })
      end
      if converters[:year]
        converters_list << Converter.build_year_field_converters(converters[:year].map {|field| attribute_names.index(field) })
      end
      header_converters = Converter.build_header_field_to_attribute_converter(attribute_name_to_header_field_map)
      parser_converters = converters_list.map {|converters| converters[:parser_converter] }.freeze
      combined_parser_converters = lambda do |field, field_info|
        parser_converters.each {|converter| field = converter[field, field_info] }
        field
      end
      write_converters = converters_list.map {|converters| converters[:write_converter] }.freeze
      combined_write_converters = lambda do |field, field_info|
        write_converters.each {|converter| field = converter[field, field_info] }
        field
      end
      klass.define_singleton_method(:header_converters) { header_converters }
      klass.define_singleton_method(:parser_converters) { combined_parser_converters }
      klass.define_singleton_method(:write_converters) { combined_write_converters }
  
      klass.attr_reader(*attribute_names)
      klass.extend(ClassMethods)
      klass.include(Data)
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
      self.class.attribute_names.map {|attribute| public_send(attribute) }
    end

    def to_h
      self.class.attribute_names.zip(to_a).to_h
    end
  end
end
