require_relative "../base_item"

module Greeve
  module Map
    # Returns a list of contestable solar systems and the NPC faction currently
    # occupying them. It should be noted that this only returns a non-zero ID if
    # the occupying faction is not the sovereign faction.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/map/map_facwarsystems.html
    class FacWarSystems < Greeve::BaseItem
      endpoint "map/FacWarSystems"

      rowset :solar_systems, xpath: "eveapi/result/rowset[@name='solarSystems']" do
        attribute :solar_system_id,         xpath: "@solarSystemID",         type: :integer
        attribute :solar_system_name,       xpath: "@solarSystemName",       type: :string
        attribute :occupying_faction_id,    xpath: "@occupyingFactionID",    type: :integer
        attribute :occupying_faction_name,  xpath: "@occupyingFactionName",  type: :string
        attribute :owning_faction_id,       xpath: "@owningFactionID",       type: :integer
        attribute :owning_faction_name,     xpath: "@owningFactionName",     type: :string
        attribute :contested,               xpath: "@contested",             type: :boolean
        attribute :victory_points,          xpath: "@victoryPoints",         type: :integer
        attribute :victory_point_threshold, xpath: "@victoryPointThreshold", type: :integer
      end

      def initialize(opts = {})
        super(opts)
      end
    end
  end
end
