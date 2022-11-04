module Meibo
  class DataSet
    attr_reader :roster

    def initialize(data, roster:)
      @data = data
      @data_hash = data.to_h {|datum| [datum.sourced_id, datum] }
      @roster = roster
    end

    def <<(new_data)
      raise DataNotFoundError, "sourcedIdがありません" unless new_data.sourced_id
      raise SourcedIdDuplicatedError, 'sourcedIdが重複しています' if @data_hash.key?(new_data.sourced_id)

      @data << new_data
      @data_hash[new_data.sourced_id] = new_data
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

    def empty?
      @data.empty?
    end

    def find(sourced_id)
      @data_hash.fetch(sourced_id)
    rescue KeyError
      raise DataNotFoundError, "sourcedId: #{sourced_id} が見つかりません"
    end

    def to_a
      @data
    end
  end
end
