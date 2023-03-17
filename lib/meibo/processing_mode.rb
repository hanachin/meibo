# frozen_string_literal: true

module Meibo
  class ProcessingMode
    attr_reader :mode

    class << self
      def absent
        @absent ||= ProcessingMode.new("absent")
      end

      def bulk
        @bulk ||= ProcessingMode.new("bulk")
      end

      def delta
        @delta ||= ProcessingMode.new("delta")
      end
    end

    def initialize(mode)
      @mode = mode
      freeze
    end

    def absent?
      @mode == "absent"
    end

    def bulk?
      @mode == "bulk"
    end

    def delta?
      @mode == "delta"
    end

    def ==(other)
      case other
      when ProcessingMode
        @mode == other.mode
      when String
        to_s == other
      else
        false
      end
    end

    def to_s
      @mode
    end
  end
end
