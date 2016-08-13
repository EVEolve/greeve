module Greeve
  # EVE API data.
  module API
    # An abstract class used to map XML responses from the EVE XML API into Ruby
    # objects. This class is designed to be subclassed by classes representing
    # the specific EVE API resources.
    class BaseItem

      # Map an XML attribute to a Ruby object.
      #
      # @param name [Symbol] the Ruby name for this attribute
      #
      # @option xpath [Symbol] the xpath string used to locate the attribute in
      #   the XML element
      # @option type [:integer, :numeric, :string] method used to coerce the XML
      #   value
      #
      # @return the value located at the xpath
      def self.attribute(name, opts = {})
        name = name.to_sym
        @attributes ||= {}

        raise "Attribute `#{name}` defined more than once" if @attributes[name]
        raise "`:xpath` not specified for `#{name}`" unless opts[:xpath]

        @attributes[name] = {
          xpath: opts[:xpath],
          type: opts[:type],
        }

        define_method(name) do
          value = @xml_element.locate(opts[:xpath]).first

          case opts[:type]
          when :integer
            value.to_i
          when :numeric
            value.to_f
          when :string
            value.to_s
          else
            value
          end
        end
      end

      # @param xml_element [Ox::Element] the root XML element for this item
      def initialize(xml_element)
        @xml_element = xml_element

        # TODO: Force BaseItem to be an abstract class.
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

      # :nodoc:
      def to_s
        attrs =
          self.class.instance_variable_get(:@attributes)
            .map { |name, opts| "#{name}: #{__send__(name)}" }
            .join("\n")
      end

    end
  end
end
