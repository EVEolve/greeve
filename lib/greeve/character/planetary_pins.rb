require_relative "../base_item"

module Greeve
  module Character
    # Planetary pins for colonies owned by character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_planetarypins.html
    class PlanetaryPins < Greeve::BaseItem
      endpoint "char/PlanetaryPins"

      rowset :pins, xpath: "eveapi/result/rowset[@name='pins']" do
        attribute :pin_id,             xpath: "@pinID",            type: :integer
        attribute :type_id,            xpath: "@typeID",           type: :integer
        attribute :type_name,          xpath: "@typeName",         type: :string
        attribute :schematic_id,       xpath: "@schematicID",      type: :integer
        attribute :last_launch_time,   xpath: "@lastLaunchTime",   type: :datetime
        attribute :cycle_time,         xpath: "@cycleTime",        type: :integer
        attribute :quantity_per_cycle, xpath: "@quantityPerCycle", type: :integer
        attribute :install_time,       xpath: "@installTime",      type: :datetime
        attribute :expiry_time,        xpath: "@expiryTime",       type: :datetime
        attribute :content_type_id,    xpath: "@contentTypeID",    type: :integer
        attribute :content_type_name,  xpath: "@contentTypeName",  type: :string
        attribute :content_quantity,   xpath: "@contentQuantity",  type: :integer
        attribute :longitude,          xpath: "@longitude",        type: :numeric
        attribute :latitude,           xpath: "@latitude",         type: :numeric
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
