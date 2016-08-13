require "typhoeus"
require "ox"

BASE_URL = "https://api.eveonline.com/eve"

response = Typhoeus.get("#{BASE_URL}/CharacterInfo.xml.aspx?characterID=462421468")

character_info = Ox.parse(response.body)

result = character_info.locate("eveapi/result").first


module Greeve
  module API
    class BaseItem

      def self.attribute(name, options = {})
        name = name.to_sym
        @attributes ||= {}

        raise "Attribute `#{name}` defined more than once" if @attributes[name]
        raise "`:xpath` not specified for `#{name}`" unless options[:xpath]

        @attributes[name] = {
          xpath: options[:xpath],
          type: options[:type],
        }

        define_method(name) do
          value = @xml_element.locate(options[:xpath]).first

          case options[:type]
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

      def initialize(xml_element)
        @xml_element = xml_element
      end

      def inspect
        attrs = to_s

        unless attrs.empty?
          attrs = attrs.split("\n").map { |l| "  #{l}" }.join("\n")
          attrs = "\n#{attrs}\n"
        end

        "#<#{self.class.name}:#{object_id}#{attrs}>"
      end

      def to_s
        attrs =
          self.class.instance_variable_get(:@attributes)
            .map { |name, opts| "#{name}: #{__send__(name)}" }
            .join("\n")
      end

    end

    class CharacterInfo < BaseItem
      attribute :character_id,     xpath: "characterID/?[0]",     type: :integer
      attribute :character_name,   xpath: "characterName/?[0]",   type: :string
      attribute :race,             xpath: "race/?[0]",            type: :string
      attribute :bloodline_id,     xpath: "bloodlineID/?[0]",     type: :integer
      attribute :bloodline,        xpath: "bloodline/?[0]",       type: :string
      attribute :ancestry_id,      xpath: "ancestryID/?[0]",      type: :integer
      attribute :ancestry,         xpath: "ancestry/?[0]",        type: :string
      attribute :corporation_id,   xpath: "corporationID/?[0]",   type: :integer
      attribute :corporation,      xpath: "corporation/?[0]",     type: :string
      attribute :corporation_date, xpath: "corporationDate/?[0]", type: :string
      attribute :security_status,  xpath: "securityStatus/?[0]",  type: :numeric
    end
  end
end

c = Greeve::API::CharacterInfo.new(result)

require "pry"; binding.pry
