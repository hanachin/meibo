# frozen_string_literal: true

module Meibo
  class Error < StandardError; end
  class CsvFileNotFoundError < Error; end
  class DataNotFoundError < Error; end
  class InvalidDataTypeError < Error; end
  class MissingDataError < Error; end
  class MissingHeadersError < Error; end
  class NotSupportedError < Error; end
  class ScrambledHeadersError < Error; end
  class SourcedIdDuplicatedError < Error; end
end
