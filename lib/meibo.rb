# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/meibo/factory_bot")
loader.setup
loader.eager_load

require_relative "meibo/version"

module Meibo
  CSV_ENCODING = 'UTF-8'
end
