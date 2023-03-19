# frozen_string_literal: true

module Meibo
  module JapanProfile
    class UserM0 < ::Meibo::UserM0
      include User::InstanceMethods
      extend User::ClassMethods

      define_additional_definition
    end
  end
end
