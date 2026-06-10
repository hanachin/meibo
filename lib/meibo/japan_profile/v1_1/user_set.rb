# frozen_string_literal: true

module Meibo
  module JapanProfile
    module V1_1
      class UserSet < ::Meibo::OneRoster::V1_2::UserSet
        def check_semantically_consistent
          super

          each do |user|
            roster.classes.find(user.home_class) if user.home_class
          end
        end
      end
    end
  end
end
