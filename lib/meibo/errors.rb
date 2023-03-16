# frozen_string_literal: true

module Meibo
  class Error < StandardError; end
  class CsvFileNotFoundError < Error; end
  class DataNotFoundError < Error; end

  class InvalidDataTypeError < Error
    attr_reader :field, :field_info

    def initialize(message = nil, field:, field_info:, **kw)
      super(message, **kw)

      @field = field
      @field_info = field_info
    end
  end

  class MissingDataError < Error; end

  class MissingHeaderFieldsError < Error
    attr_reader :missing_header_fields

    def initialize(message = nil, missing_header_fields:, **kw)
      super(message, **kw)
      @missing_header_fields = missing_header_fields
    end
  end

  class NotSupportedError < Error; end
  class ScrambledHeaderFieldsError < Error; end
  class SourcedIdDuplicatedError < Error; end
  class SubjectsAndSubjectCodesLengthNotMatch < Error; end
end
