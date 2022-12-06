module Meibo
  class Builder
    module BaseBuilder
      def create(klass)
        builder_klass = Class.new(klass)
        builder_klass.prepend(self)
        builder_klass.attr_reader(*builder_attribute_names)
        builder_klass
      end
    end
  end
end
