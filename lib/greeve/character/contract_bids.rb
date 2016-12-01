require_relative "../base_item"

module Greeve
  module Character
    # Bids that have been placed on the character's auctions.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_contractbids.html
    class ContractBids < Greeve::BaseItem
      endpoint "char/ContractBids"

      rowset :bid_list, xpath: "eveapi/result/rowset[@name='bidList']" do
        attribute :amount,      xpath: "@amount",     type: :numeric
        attribute :date_bid,    xpath: "@dateBid",    type: :datetime
        attribute :bidder_id,   xpath: "@bidderID",   type: :integer
        attribute :contract_id, xpath: "@contractID", type: :integer
        attribute :bid_id,      xpath: "@bidID",      type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
