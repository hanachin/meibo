module Meibo
  class DataSet
    include Enumerable

    attr_reader :roster

    def initialize(data, roster:)
      @data = data
      @roster = roster
      @cache = {}
    end

    def <<(new_data)
      raise DataNotFoundError, "sourcedIdがありません" unless new_data.sourced_id
      raise SourcedIdDuplicatedError, 'sourcedIdが重複しています' if data_by_sourced_id.key?(new_data.sourced_id)

      @data << new_data
      @cache.clear
    end

    def check_semantically_consistent
      unless @data.size == data_by_sourced_id.size
        raise SourcedIdDuplicatedError, 'sourcedIdが重複しています'
      end

      unless data_by_sourced_id[nil].nil?
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
      data_by_sourced_id.fetch(sourced_id)
    rescue KeyError
      raise DataNotFoundError, "sourcedId: #{sourced_id} が見つかりません"
    end

    def where(**conditions)
      group_cache[conditions.keys.sort][conditions.values]
    end

    private

    def group_cache
      @cache[:group_cache] ||= Hash.new do |hash, keys|
        hash[keys] = @data.group_by {|datum| keys.map {|attribute| datum.public_send(attribute) } }.to_h do |values, data|
          [values, new(data)]
        end
      end
    end

    def data_by_sourced_id
      @cache[:data_by_sourced_id] ||= @data.to_h {|datum| [datum.sourced_id, datum] }
    end

    def new(data)
      self.class.new(data, roster: roster)
    end
  end
end
