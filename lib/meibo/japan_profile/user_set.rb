# frozen_string_literal: true

module Meibo
  module JapanProfile
    class UserSet < ::Meibo::UserSet
      def check_semantically_consistent
        super
        each do |user|
          if user.home_class
            roster.classes.find(user.home_class)
          end
        end
      end
    end
  end
end
