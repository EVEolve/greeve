module Greeve
  module Helpers
    # Adds the `#to_h` method.
    module AttributeToHash
      # The (private) `#_attributes` method must be implemented for this method
      # to work.
      #
      # @return [Hash] a hash of non-nil attributes
      def to_h
        _attributes
        .keys
        .map { |name|
          value = __send__(name)
          value = value.to_a if value.is_a?(Rowset)
          value = value.to_h if value.is_a?(Namespace)

          [name, value]
        }
        .to_h
        .reject { |k, v| v.nil? }
      end
    end
  end
end
