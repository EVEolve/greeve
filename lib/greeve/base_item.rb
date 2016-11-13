require "bigdecimal"
require "time"

require_relative "response_error"
require_relative "helpers/add_attribute"
require_relative "helpers/attribute_to_hash"
require_relative "helpers/define_dsl_methods"
require_relative "namespace"
require_relative "rowset"

module Greeve
  # An abstract class used to map XML responses from the EVE XML API into Ruby
  # objects. This class is designed to be subclassed by classes representing
  # the specific EVE API resources.
  class BaseItem
    extend Greeve::Helpers::AddAttribute
    extend Greeve::Helpers::DefineDSLMethods
    include Greeve::Helpers::AttributeToHash

    # A DSL method to map an XML attribute to a Ruby object.
    #
    # @param name [Symbol] the Ruby name for this attribute
    #
    # @option opts [Symbol] :xpath the xpath string used to locate the attribute
    #   in the XML element
    # @option opts [:integer, :numeric, :string] :type method used to coerce the
    #   XML value
    #
    # @example
    #   attribute :character_id, xpath: "characterID/?[0]", type: :integer
    def self.attribute(name, opts = {})
      @attributes ||= {}

      add_attribute(name, opts)
      define_attribute_method(:class, name, opts)
    end

    # A DSL method to nest a set of attributes within a namespace.
    #
    # @param name [Symbol] the Ruby name for this namespace
    #
    # @option opts [Symbol] :xpath the xpath string used to locate the namespace
    #   in the XML element
    #
    # @example
    #   namespace :general_settings, xpath: "eveapi/result/generalSettings" do
    #     attribute :usage_flags, xpath: "usageFlags/?[0]", type: :integer
    #   end
    def self.namespace(name, opts = {}, &block)
      @attributes ||= {}

      opts[:type] = :namespace

      add_attribute(name, opts)
      define_namespace_method(:class, name, opts, &block)
    end

    # A DSL method to map an XML rowset to a Ruby object.
    #
    # @param name [Symbol] the Ruby name for this attribute
    #
    # @option opts [Symbol] :xpath the xpath string used to locate the attribute
    #   in the XML element
    #
    # @example
    #   rowset :employment_history, xpath: "eveapi/result/rowset[@name='employmentHistory']" do
    #     attribute :record_id,        xpath: "@recordID",        type: :integer
    #     attribute :corporation_id,   xpath: "@corporationID",   type: :integer
    #     attribute :corporation_name, xpath: "@corporationName", type: :string
    #     attribute :start_date,       xpath: "@startDate",       type: :datetime
    #   end
    def self.rowset(name, opts = {}, &block)
      @attributes ||= {}

      opts[:type] = :rowset

      add_attribute(name, opts)

      define_method(name) do
        ivar = instance_variable_get(:"@#{name}")
        return ivar unless ivar.nil?

        # Since Ox doesn't support the xpath [@k='v'] syntax, parse it out
        # with a regex (captures :path, :attr, :attr_value).
        attr_regex = %r{\A(?<path>.*?)\[@(?<attr>\w+)=['"](?<attr_value>\w+)['"]\]\z}
        match = opts[:xpath].match(attr_regex)

        rowset_element =
          @xml_element
            .locate(match[:path])
            .find { |e| e.attributes[match[:attr].to_sym] == match[:attr_value] }

        rowset = Rowset.new(name, rowset_element, &block)

        instance_variable_set(:"@#{name}", rowset)
      end
    end

    # A DSL method to specify the API endpoint.
    #
    # @param path [String] path of the API endpoint. It shouldn't include the
    #   leading slash `/`, or the extension `.xml.aspx`
    #
    # @example
    #   endpoint "eve/CharacterInfo"
    def self.endpoint(path)
      raise ArgumentError, "Endpoint shouldn't start with a slash" \
        if path.start_with?("/")

      @endpoint = path
    end

    # @abstract Subclass and use the DSL methods to map API endpoints to objects
    #
    # @option opts [String, Fixnum] :key API key
    # @option opts [String] :vcode API vCode
    # @option opts [Hash<String, String>] :query_params a hash of HTTP query
    #   params that specify how a value maps to the API request
    #
    # @example
    #   super(query_params: {
    #     "characterID" => character_id,
    #   })
    def initialize(opts = {})
      raise TypeError, "Cannot instantiate an abstract class" \
        if self.class.superclass != Greeve::BaseItem

      @api_key = opts[:key]
      @api_vcode = opts[:vcode]
      @query_params = opts[:query_params] || {}

      if @api_key && @api_vcode
        @query_params.merge!({
          "keyID" => @api_key,
          "vCode" => @api_vcode,
        })
      end

      refresh
    end

    # Query the API, refreshing this object's data.
    #
    # @return true if the endpoint was fetched (HTTP request sent), false if
    #   the cache hasn't expired
    def refresh
      return false unless cache_expired?

      fetch
      true
    end

    # @return true if the API cache timer has expired and this object can
    #   be refreshed
    def cache_expired?
      !(cached_until && cached_until > Time.now)
    end

    # @return [Time, nil] time when the cache expires and the resource can be
    #   refreshed (sends an HTTP request)
    def cached_until
      return unless @xml_element

      _cached_until = @xml_element.locate("eveapi/cachedUntil/?[0]").first
      _cached_until ? Time.parse(_cached_until + " UTC") : nil
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
      self.class.instance_variable_get(:@attributes) || {}
    end

    # @return [String] the class's endpoint path
    def endpoint
      self.class.instance_variable_get(:@endpoint)
    end

    # Fetch data from the API HTTP endpoint.
    def fetch
      url = "#{Greeve::EVE_API_BASE_URL}/#{endpoint}.xml.aspx"
      response = Typhoeus.get(url, params: @query_params)

      raise ResponseError.new(
        code: response.code,
        status_message: response.status_message,
      ) unless response.success?

      @xml_element = Ox.parse(response.body)

      _attributes.keys.each do |name|
        instance_variable_set(:"@#{name}", nil)
      end

      @xml_element
    end
  end
end
