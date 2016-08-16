module Greeve
  # An abstract class used to map XML responses from the EVE XML API into Ruby
  # objects. This class is designed to be subclassed by classes representing
  # the specific EVE API resources.
  class BaseItem

    # A DSL method to map an XML attribute to a Ruby object.
    #
    # @param name [Symbol] the Ruby name for this attribute
    #
    # @option opts [Symbol] :xpath the xpath string used to locate the attribute
    #   in the XML element
    # @option opts [:integer, :numeric, :string] :type method used to coerce the
    #   XML value
    #
    # @return the value located at the xpath
    #
    # @example
    #   attribute :character_id, xpath: "characterID/?[0]", type: :integer
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

    # A DSL method to specify the API endpoint.
    #
    # @param path [String] path of the API endpoint. Doesn't need to include the
    #   leading slash `/`, or the extension `.xml.aspx`
    #
    # @example
    #   endpoint "eve/CharacterInfo"
    def self.endpoint(path)
      # Remove leading slash and file extension.
      @endpoint = endpoint = path.gsub(/\A\/*(.*?)(?:\.xml)?(?:\.aspx)?\z/, '\1')

      define_method(:endpoint) { endpoint }
      private_class_method :endpoint
    end

    # @param xml_element [Ox::Element] the root XML element for this item
    def initialize(xml_element)
      @xml_element = xml_element

      raise TypeError, "Cannot instantiate an abstract class" \
        if self.class.superclass != Greeve::BaseItem
    end

    # Query the API, refreshing this object's data.
    def refresh
      raise NotImplementedError
    end

    # @return true if the API cache timer has expired and this object can
    #   be refreshed.
    def cache_expired?
      raise NotImplementedError
    end

    # def get(endpoint, params = {})
    #   url = "#{Greeve::API::BASE_URL}/#{endpoint}"

    #   unless params.empty?
    #     query_params =
    #       params
    #         .map { |k, v| "#{k}=#{v}" }
    #         .join("&")

    #     url = "#{url}?#{query_params}"
    #   end

    #   Typhoeus.get(url)
    # end

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
