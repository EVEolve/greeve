require_relative "../base_item"

module Greeve
  module Corporation
    # List of corporation starbases.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_starbaselist.html
    class StarbaseList < Greeve::BaseItem
      endpoint "corp/StarbaseList"

      rowset :starbases, xpath: "eveapi/result/rowset[@name='starbases']" do
        attribute :item_id,           xpath: "@itemID",          type: :integer
        attribute :type_id,           xpath: "@typeID",          type: :integer
        attribute :location_id,       xpath: "@locationID",      type: :integer
        attribute :moon_id,           xpath: "@moonID",          type: :integer
        attribute :state,             xpath: "@state",           type: :integer
        attribute :state_timestamp,   xpath: "@stateTimestamp",  type: :datetime
        attribute :online_timestamp,  xpath: "@onlineTimestamp", type: :datetime
        attribute :standing_owner_id, xpath: "@standingOwnerID", type: :integer
      end
    end
  end
end
