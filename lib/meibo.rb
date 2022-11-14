# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/meibo/errors.rb")
loader.ignore("#{__dir__}/meibo/factory_bot")
loader.setup

require_relative "meibo/version"
require_relative "meibo/errors"

module Meibo
  CSV_ENCODING = 'UTF-8'
  ENUM_EXT_PATTERN = /\Aext:[a-zA-Z0-9\.\-_]+\z/

  class << self
    attr_accessor :default_profile
  end
end

loader.eager_load

Meibo.default_profile = Meibo::Profile.new
