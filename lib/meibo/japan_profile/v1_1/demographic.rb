# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class Demographic < ::Meibo::OneRoster::V1_2::Demographic
        define_converters(superclass.converters.merge(enum: { sex: SEX.values.freeze }))
      end
    end
  end
end
