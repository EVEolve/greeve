require_relative "../base_item"

module Greeve
  module Character
    # Planetary colonies owned by character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_planetarycolonies.html
    class PlanetaryColonies < Greeve::BaseItem
      endpoint "char/PlanetaryColonies"

      rowset :colonies, xpath: "eveapi/result/rowset[@name='colonies']" do
        attribute :solar_system_id,   xpath: "@solarSystemID",   type: :integer
        attribute :solar_system_name, xpath: "@solarSystemName", type: :string
        attribute :planet_id,         xpath: "@planetID",        type: :integer
        attribute :planet_name,       xpath: "@planetName",      type: :string
        attribute :planet_type_id,    xpath: "@planetTypeID",    type: :integer
        attribute :planet_type_name,  xpath: "@planetTypeName",  type: :string
        attribute :owner_id,          xpath: "@ownerID",         type: :integer
        attribute :owner_name,        xpath: "@ownerName",       type: :string
        attribute :last_update,       xpath: "@lastUpdate",      type: :datetime
        attribute :upgrade_level,     xpath: "@upgradeLevel",    type: :integer
        attribute :number_of_pins,    xpath: "@numberOfPins",    type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
