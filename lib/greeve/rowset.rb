require_relative "row"

module Greeve
  # Represents an XML `rowset` element.
  class Rowset
    include Enumerable

    # @return [Symbol] name of the rowset
    attr_reader :name

    # @param name [Symbol] name of the rowset
    # @param xml_element [Ox::Element] the xml rowset element for this item
    # @yield a block containing the attribute definitions for {Row}
    def initialize(name, xml_element, &block)
      @name = name
      @xml_element = xml_element
      @attributes = {}
      @rows = nil

      # Load the attribute configuration in the rowset block.
      instance_eval(&block)

      # Disable the #attribute method since the attributes have been configured.
      define_singleton_method(:attribute) { raise NoMethodError, "private method" }
    end

    # :nodoc:
    def each(&block)
      rows.each(&block)
    end

    # @return [Array] an array of rows and their non-nil attributes
    def to_a
      map(&:to_h)
    end

    # :nodoc:
    def inspect
      "#<#{self.class.name}:#{object_id} name: #{@name}>"
    end

    # Map an XML attribute to a Ruby object.
    #
    # @!visibility private
    # @see {Greeve::BaseItem.attribute}
    def attribute(name, opts = {})
      name = name.to_sym

      raise "Attribute `#{name}` defined more than once" if @attributes[name]
      raise "`:xpath` not specified for `#{name}`" unless opts[:xpath]

      @attributes[name] = {
        xpath: opts[:xpath],
        type: opts[:type],
      }
    end

    private

    # @return [Array<Row>] an array of rows in the rowset
    def rows
      return @rows unless @rows.nil?

      rows = @xml_element.locate("row").map do |row_element|
        Row.new(row_element, @attributes)
      end

      @rows = rows
    end
  end
end
