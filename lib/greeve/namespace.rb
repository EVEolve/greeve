require_relative "helpers/add_attribute"
require_relative "helpers/attribute_to_hash"
require_relative "helpers/define_dsl_methods"

module Greeve
  # Contains a group of attributes.
  class Namespace
    include Greeve::Helpers::AddAttribute
    include Greeve::Helpers::DefineDSLMethods
    include Greeve::Helpers::AttributeToHash

    # @return [Symbol] name of the namespace
    attr_reader :name

    # @param name [Symbol] name of the namespace
    # @param xml_element [Ox::Element] the xml namespace element for this item
    # @yield a block containing the attribute definitions
    def initialize(name, xml_element, &block)
      @name = name
      @xml_element = xml_element
      @attributes = {}

      # Load the attribute configuration in the rowset block.
      instance_eval(&block)

      # Disable the DSL methods since the attributes have been configured.
      define_singleton_method(:attribute) { raise NoMethodError, "private method" }
      define_singleton_method(:namespace) { raise NoMethodError, "private method" }
    end

    # :nodoc:
    def inspect
      attrs = to_s.lines[1..-1].join

      "#<#{self.class.name}:#{object_id} name: #{@name}\n#{attrs}\n>"
    end

    # @return [String] a string representation of the non-nil attributes
    def to_s
      "#{@name}\n" +
      to_h
        .map { |k, v|
          v = v.to_s("F") if v.is_a?(BigDecimal)
          "  #{k}: #{v}"
        }
        .join("\n")
    end

    private

    # @return [Hash] the hash of attributes for this object
    def _attributes
      @attributes || {}
    end

    # Map an XML attribute to a Ruby object.
    #
    # @see BaseItem.attribute
    def attribute(name, opts = {})
      add_attribute(name, opts)
      define_attribute_method(:instance, name, opts)
    end

    # Nest a set of XML attributes inside a namespace.
    #
    # @see BaseItem.namespace
    def namespace(name, opts = {}, &block)
      opts[:type] = :namespace

      add_attribute(name, opts)
      define_namespace_method(:instance, name, opts, &block)
    end
  end
end
