require_relative "../base_item"

module Greeve
  module Map
    # Provides sovereignty / ownership information for solar systems in New Eden,
    # excluding wormhole space.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/map/map_sovereignty.html
    class Sovereignty < Greeve::BaseItem
      endpoint "map/Sovereignty"

      rowset :solar_systems, xpath: "eveapi/result/rowset[@name='solarSystems']" do
        attribute :solar_system_id,   xpath: "@solarSystemID",   type: :integer
        attribute :alliance_id,       xpath: "@allianceID",      type: :integer
        attribute :faction_id,        xpath: "@factionID",       type: :integer
        attribute :corporation_id,    xpath: "@corporationID",   type: :integer
        attribute :solar_system_name, xpath: "@solarSystemName", type: :string
      end
    end
  end
end
