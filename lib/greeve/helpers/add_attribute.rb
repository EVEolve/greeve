module Greeve
  module Helpers
    # Adds a helper method to add an attribute to the attributes hash instance
    # variable.
    module AddAttribute
      private

      # Add an attribute to the attributes hash instance variable.
      #
      # @param name [String] name of the attribute method
      # @param opts [Hash] option hash passed from the attribute DSL helper method
      def add_attribute(name, opts = {})
        name = name.to_sym

        raise "Attribute `#{name}` defined more than once" if @attributes[name]
        raise "`:xpath` not specified for `#{name}`" unless opts[:xpath]

        @attributes[name] = {
          xpath: opts[:xpath],
          type: opts[:type],
        }
      end
    end
  end
end
