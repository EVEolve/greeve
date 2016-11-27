require_relative "../base_item"

module Greeve
  module Character
    # Character market orders.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_marketorders.html
    class MarketOrders < Greeve::BaseItem
      endpoint "char/MarketOrders"

      rowset :orders, xpath: "eveapi/result/rowset[@name='orders']" do
        attribute :order_id,      xpath: "@orderID",      type: :integer
        attribute :char_id,       xpath: "@charID",       type: :integer
        attribute :station_id,    xpath: "@stationID",    type: :integer
        attribute :vol_entered,   xpath: "@volEntered",   type: :integer
        attribute :vol_remaining, xpath: "@volRemaining", type: :integer
        attribute :min_volume,    xpath: "@minVolume",    type: :integer
        attribute :order_state,   xpath: "@orderState",   type: :integer
        attribute :type_id,       xpath: "@typeID",       type: :integer
        attribute :range,         xpath: "@range",        type: :integer
        attribute :account_key,   xpath: "@accountKey",   type: :integer
        attribute :duration,      xpath: "@duration",     type: :integer
        attribute :escrow,        xpath: "@escrow",       type: :numeric
        attribute :price,         xpath: "@price",        type: :numeric
        attribute :bid,           xpath: "@bid",          type: :boolean
        attribute :issued,        xpath: "@issued",       type: :datetime
      end

      # @param character_id [Integer] EVE character ID
      #
      # @option opts [Integer] :order_id Optional order ID of order to retrieve
      def initialize(character_id, opts = {})
        order_id = opts.delete(:order_id)

        opts[:query_params] = { "characterID" => character_id }
        opts[:query_params]["orderID"] = order_id if order_id

        super(opts)
      end
    end
  end
end
