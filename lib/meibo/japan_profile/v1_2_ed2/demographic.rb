# frozen_string_literal: true

module Meibo
  module JapanProfile::V1_2_Ed2
    class Demographic < ::Meibo::Demographic
      define_converters(superclass.converters.merge(enum: { sex: SEX.values.freeze }))
    end
  end
end
