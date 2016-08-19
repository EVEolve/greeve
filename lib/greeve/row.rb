module Greeve
  # Represents an XML `row` element, contained in a {Rowset}.
  class Row
    # @param xml_element [Ox::Element] the xml row element for this item
    # @param attributes [Hash] the hash of attribute definitions for this row
    def initialize(xml_element, attributes)
      @xml_element = xml_element
      @attributes = attributes

      attributes.each do |name, opts|
        define_singleton_method(name) do
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

    # :nodoc:
    def inspect
      attrs = to_s

      unless attrs.empty?
        attrs = attrs.split("\n").map { |l| "  #{l}" }.join("\n")
        attrs = "\n#{attrs}\n"
      end

      "#<#{self.class.name}:#{object_id}#{attrs}>"
    end

    # @return [String] a string representation of the non-nil attributes
    def to_s
      to_h
        .map { |k, v| "#{k}: #{v}" }
        .join("\n")
    end

    # @return [Hash] a hash of non-nil attributes
    def to_h
      @attributes
        .keys
        .map { |name|
          value = __send__(name)
          value = value.to_a if value.is_a?(Rowset)

          [name, value]
        }
        .to_h
        .reject { |k, v| v.nil? }
    end
  end
end
