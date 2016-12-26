require_relative "../base_item"

module Greeve
  module Eve
    # A list of conquerable stations in New Eden.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_conquerablestationlist.html
    class ConquerableStationList < Greeve::BaseItem
      endpoint "eve/ConquerableStationList"

      rowset :outposts, xpath: "eveapi/result/rowset[@name='outposts']" do
        attribute :station_id,       xpath: "@stationID",       type: :integer
        attribute :station_name,     xpath: "@stationName",     type: :string
        attribute :station_type_id,  xpath: "@stationTypeID",   type: :integer
        attribute :solar_system_id,  xpath: "@solarSystemID",   type: :integer
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :x,                xpath: "@x",               type: :integer
        attribute :y,                xpath: "@y",               type: :integer
        attribute :z,                xpath: "@z",               type: :integer
      end
    end
  end
end
