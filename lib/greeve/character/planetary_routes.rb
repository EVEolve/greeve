require_relative "../base_item"

module Greeve
  module Character
    # Planetary routes for colonies owned by character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_planetaryroutes.html
    class PlanetaryRoutes < Greeve::BaseItem
      endpoint "char/PlanetaryRoutes"

      rowset :routes, xpath: "eveapi/result/rowset[@name='routes']" do
        attribute :route_id,           xpath: "@routeID",          type: :integer
        attribute :source_pin_id,      xpath: "@sourcePinID",      type: :integer
        attribute :destination_pin_id, xpath: "@destinationPinID", type: :integer
        attribute :content_type_id,    xpath: "@contentTypeID",    type: :integer
        attribute :content_type_name,  xpath: "@contentTypeName",  type: :string
        attribute :quantity,           xpath: "@quantity",         type: :integer
        attribute :waypoint_1,         xpath: "@waypoint1",        type: :integer
        attribute :waypoint_2,         xpath: "@waypoint2",        type: :integer
        attribute :waypoint_3,         xpath: "@waypoint3",        type: :integer
        attribute :waypoint_4,         xpath: "@waypoint4",        type: :integer
        attribute :waypoint_5,         xpath: "@waypoint5",        type: :integer
      end

      # @param character_id [Integer] EVE character ID
      # @param planet_id [Integer] planet ID. Can be obtained from
      #   {Character::PlanetaryColonies}
      def initialize(character_id, planet_id, opts = {})
        opts[:query_params] = {
          "characterID" => character_id,
          "planetID" => planet_id,
        }

        super(opts)
      end
    end
  end
end
