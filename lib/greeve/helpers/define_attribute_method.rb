module Greeve
  module Helpers
    # Adds a helper method to define a class or instance method for a given
    # attribute.
    module DefineAttributeMethod
      private

      # Define a class or instance method for a given attribute.
      #
      # @param scope [:class, :instance] define the attribute names as class or
      #   instance methods
      # @param name [String] name of the attribute method
      # @param opts [Hash] option hash passed from the attribute DSL helper method
      def define_attribute_method(scope, name, opts = {})
        method = scope == :instance ? :define_singleton_method : :define_method

        send(method, name) do
          ivar = instance_variable_get(:"@#{name}")
          return ivar unless ivar.nil?

          value = @xml_element.locate(opts[:xpath]).first

          unless value.nil?
            value =
              case opts[:type]
              when :integer
                value.to_i
              when :numeric
                BigDecimal.new(value)
              when :boolean
                value == "1" || value.downcase == "true"
              when :string
                value.to_s
              when :datetime
                Time.parse(value + " UTC")
              end
          end

          instance_variable_set(:"@#{name}", value)
        end
      end
    end
  end
end
