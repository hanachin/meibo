module Meibo
  class DataSet
    class SemanticallyInconsistentError < Error; end
    class DataNotFoundError < SemanticallyInconsistentError; end
    class SourcedIdDuplicatedError < SemanticallyInconsistentError; end

    def initialize(data)
      @data = data
      @data_hash = data.to_h {|datum| [datum.sourced_id, datum] }
    end

    def check_semantically_consistent
      unless @data.size == @data_hash.size
        raise SourcedIdDuplicatedError, 'sourcedIdが重複しています'
      end

      unless @data_hash[nil].nil?
        raise DataNotFoundError, "sourcedIdがありません"
      end
    end

    def each(...)
      @data.each(...)
    end

    def find_by_sourced_id(sourced_id)
      @data_hash.fetch(sourced_id)
    rescue KeyError
      raise DataNotFoundError, "sourcedId: #{sourced_id} が見つかりません"
    end

    def to_a
      @data
    end
  end
end
