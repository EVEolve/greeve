require_relative "helpers/attribute_to_hash"
require_relative "helpers/define_dsl_methods"

module Greeve
  # Represents an XML `row` element, contained in a {Rowset}.
  class Row
    include Greeve::Helpers::AttributeToHash
    include Greeve::Helpers::DefineDSLMethods

    # @param xml_element [Ox::Element] the xml row element for this item
    # @param attributes [Hash] the hash of attribute definitions for this row
    def initialize(xml_element, attributes)
      @xml_element = xml_element
      @attributes = attributes

      attributes.each do |name, opts|
        define_attribute_method(:instance, name, opts)
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
        .map { |k, v|
          v = v.to_s("F") if v.is_a?(BigDecimal)
          "#{k}: #{v}"
        }
        .join("\n")
    end

    private

    # @return [Hash] the hash of attributes for this object
    def _attributes
      @attributes || {}
    end
  end
end
