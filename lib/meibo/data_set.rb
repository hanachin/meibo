# frozen_string_literal: true

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
      raise SourcedIdDuplicatedError, "sourcedIdが重複しています" if data_by_sourced_id.key?(new_data.sourced_id)

      @data << new_data
      @cache.clear
    end

    def check_semantically_consistent
      raise SourcedIdDuplicatedError, "sourcedIdが重複しています" unless @data.size == data_by_sourced_id.size
      raise DataNotFoundError, "sourcedIdがありません" unless data_by_sourced_id[nil].nil?
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

    def lineno(datum)
      # NOTE: add one for one-based, and add one for header line
      find_index(datum)&.+(2)
    end

    def where(**conditions)
      group_cache[conditions.keys.sort][conditions.values] || empty_set
    end

    private

    def group_cache
      @cache[:group_cache] ||= Hash.new do |hash, keys|
        hash[keys] = @data.group_by do |datum|
                       keys.map do |attribute|
                         datum.public_send(attribute)
                       end
                     end.transform_values do |data|
          new(data)
        end
      end
    end

    def data_by_sourced_id
      @cache[:data_by_sourced_id] ||= @data.to_h { |datum| [datum.sourced_id, datum] }
    end

    def new(data)
      self.class.new(data, roster: roster)
    end

    def empty_set
      @empty_set ||= new([])
    end

    def field_info_from(model, attribute_name)
      index = model.class.attribute_names.index(attribute_name)
      line = lineno(model)
      CSV::FieldInfo.new(index, line, attribute_name, false)
    end
  end
end
