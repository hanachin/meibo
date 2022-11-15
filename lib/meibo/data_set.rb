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

    def by_organization(org_sourced_id)
      data_by_org_sourced_id[org_sourced_id]
    end

    def by_user(user_sourced_id)
      data_by_user_sourced_id[user_sourced_id]
    end

    private

    def data_by_org_sourced_id
      @cache[:data_by_org_sourced_id] ||= @data.group_by(&:data_by_org_sourced_id).to_h do |org_sourced_id, data|
        [org_sourced_id, new(data)]
      end
    end

    def data_by_sourced_id
      @cache[:data_by_sourced_id] ||= @data.to_h {|datum| [datum.sourced_id, datum] }
    end

    def data_by_user_sourced_id
      @cache[:data_by_user_sourced_id] ||= @data.group_by(&:user_sourced_id).to_h do |user_sourced_id, data|
        [user_sourced_id, new(data)]
      end
    end

    def new(data)
      self.class.new(data, roster: roster)
    end
  end
end
