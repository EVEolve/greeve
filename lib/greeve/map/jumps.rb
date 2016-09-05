require_relative "../base_item"

module Greeve
  module Map
    # Returns the number of jumps in solarsystems within the last hour (doesn’t
    # include wormhole space). Only solar systems where jumps have been made are
    # listed; assume zero in case the system is not listed.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/map/map_jumps.html
    class Jumps < Greeve::BaseItem
      endpoint "map/Jumps"

      rowset :solar_systems, xpath: "eveapi/result/rowset[@name='solarSystems']" do
        attribute :solar_system_id, xpath: "@solarSystemID", type: :integer
        attribute :ship_jumps,      xpath: "@shipJumps",     type: :integer
      end
    end
  end
end
