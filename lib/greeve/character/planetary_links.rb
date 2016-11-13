require_relative "../base_item"

module Greeve
  module Character
    # Planetary links for colonies owned by character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_planetarylinks.html
    class PlanetaryLinks < Greeve::BaseItem
      endpoint "char/PlanetaryLinks"

      rowset :links, xpath: "eveapi/result/rowset[@name='links']" do
        attribute :source_pin_id,      xpath: "@sourcePinID",      type: :integer
        attribute :destination_pin_id, xpath: "@destinationPinID", type: :integer
        attribute :link_level,         xpath: "@linkLevel",        type: :integer
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
