require "bigdecimal"
require "time"

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
        ivar = instance_variable_get(:"@#{name}")
        return ivar unless ivar.nil?

        value = @xml_element.locate(opts[:xpath]).first

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

        instance_variable_set(:"@#{name}", value)
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
      @endpoint = path.gsub(/\A\/*(.*?)(?:\.xml)?(?:\.aspx)?\z/, '\1')
    end

    # @abstract Subclass and use the DSL methods to map API endpoints to objects
    #
    # @option opts [Hash<String, String>] :query_params a hash of HTTP query
    #   params that specify how a value maps to the API request
    #
    # @example
    #   super(query_params: {
    #     "characterID" => character_id,
    #   })
    def initialize(opts = {})
      @query_params = opts[:query_params] || {}

      raise TypeError, "Cannot instantiate an abstract class" \
        if self.class.superclass != Greeve::BaseItem

      refresh
    end

    # Query the API, refreshing this object's data.
    #
    # @return true if the endpoint was fetched, false if the data is still cached
    def refresh
      return false unless cache_expired?

      fetch
      true
    end

    # @return true if the API cache timer has expired and this object can
    #   be refreshed
    def cache_expired?
      return true unless @xml_element

      @xml_element.locate("eveapi/cachedUntil/?[0]").first.tap do |cached_until|
        return true unless cached_until

        expire_time = Time.parse(cached_until + " GMT")
        return true if expire_time <= Time.now
      end

      false
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
        attributes
          .map { |name, opts| "#{name}: #{__send__(name)}" }
          .join("\n")
    end

    private

    # @return [Hash] the hash of attributes for this object
    def attributes
      self.class.instance_variable_get(:@attributes) || {}
    end

    # @return [String] the class's endpoint path
    def endpoint
      self.class.instance_variable_get(:@endpoint)
    end

    # Fetch data from the API HTTP endpoint.
    def fetch
      url = "#{Greeve::EVE_API_BASE_URL}/#{endpoint}.xml.aspx"
      params = @query_params

      unless params.empty?
        query_params =
          params
            .map { |k, v| "#{k}=#{v}" }
            .join("&")

        url = "#{url}?#{query_params}"
      end

      response = Typhoeus.get(url)

      # TODO: Use a better error class.
      raise TypeError, "HTTP error #{response.code}" \
        unless (200..299).include?(response.code.to_i)

      @xml_element = Ox.parse(response.body)

      attributes.keys.each do |name|
        instance_variable_set(:"@#{name}", nil)
      end

      @xml_element
    end
  end
end
