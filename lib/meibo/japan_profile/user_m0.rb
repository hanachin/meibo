# frozen_string_literal: true

module Meibo
  module JapanProfile
    class UserM0 < ::Meibo::UserM0
      include User::InstanceMethods

      DataModel.define(self, **User::ADDITIONAL_DEFINITION)
    end
  end
end
