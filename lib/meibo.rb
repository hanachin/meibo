# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/meibo/errors.rb")
loader.ignore("#{__dir__}/meibo/factory_bot")
loader.setup

require_relative "meibo/version"
require_relative "meibo/errors"

module Meibo
  CSV_ENCODING = "UTF-8"
  ENUM_EXT_PATTERN = /\Aext:[a-zA-Z0-9.\-_]+\z/.freeze

  class << self
    def default_profile
      thread_local_data[:default_profile]
    end

    def default_profile=(default_profile)
      thread_local_data[:default_profile] = default_profile
    end

    def current_roster
      thread_local_data[:roster]
    end

    def with_profile(default_profile)
      orig_default_profile = thread_local_data[:default_profile]
      thread_local_data[:default_profile] = default_profile
      yield
    ensure
      thread_local_data[:default_profile] = orig_default_profile
    end

    def with_roster(roster)
      orig_roster = thread_local_data[:roster]
      thread_local_data[:roster] = roster
      yield
    ensure
      thread_local_data[:roster] = orig_roster
    end

    private

    def thread_local_data
      Thread.current[:__meibo] ||= {}
    end
  end
end

loader.eager_load

Meibo.default_profile = Meibo::Profiles["v1.2"]
