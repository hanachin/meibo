# frozen_string_literal: true

module Meibo
  module JapanProfile
    class Demographic < ::Meibo::Demographic
      define_converters(superclass.converters.merge(enum: { sex: SEX.values.freeze }))
    end
  end
end
