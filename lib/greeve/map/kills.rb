require_relative "../base_item"

module Greeve
  module Map
    # Provides number of ship, pod and NPC kills per solar system within the
    # last hour (doesn’t include wormhole space). Only solar systems where kills
    # have been made are listed; assume zero in case the system is not listed.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/map/map_kills.html
    class Kills < Greeve::BaseItem
      endpoint "map/Kills"

      rowset :solar_systems, xpath: "eveapi/result/rowset[@name='solarSystems']" do
        attribute :solar_system_id, xpath: "@solarSystemID", type: :integer
        attribute :ship_kills,      xpath: "@shipKills",     type: :integer
        attribute :faction_kills,   xpath: "@factionKills",  type: :integer
        attribute :pod_kills,       xpath: "@podKills",      type: :integer
      end

      def initialize(opts = {})
        super(opts)
      end
    end
  end
end
