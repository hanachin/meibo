# frozen_string_literal: true

module Meibo
  class Error < StandardError; end
  class CsvFileNotFoundError < Error; end
  class DataNotFoundError < Error; end
  class InvalidDataTypeError < Error; end
  class MissingDataError < Error; end
  class MissingHeaderFieldsError < Error
    attr_reader :missing_header_fields

    def initialize(message = nil, missing_header_fields:)
      super(message)
      @missing_header_fields = missing_header_fields
    end
  end
  class NotSupportedError < Error; end
  class ScrambledHeaderFieldsError < Error; end
  class SourcedIdDuplicatedError < Error; end
end
