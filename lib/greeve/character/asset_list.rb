require_relative "../base_item"

module Greeve
  module Character
    # Everything a character owns.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_assetlist.html
    class AssetList < Greeve::BaseItem
      endpoint "char/AssetList"

      rowset :assets, xpath: "eveapi/result/rowset[@name='assets']" do
        attribute :item_id,      xpath: "@itemID",      type: :integer
        attribute :location_id,  xpath: "@locationID",  type: :integer
        attribute :type_id,      xpath: "@typeID",      type: :integer
        attribute :quantity,     xpath: "@quantity",    type: :integer
        attribute :flag,         xpath: "@flag",        type: :integer
        attribute :singleton,    xpath: "@singleton",   type: :boolean
        attribute :raw_quantity, xpath: "@rawQuantity", type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = {
          "characterID" => character_id,
          "flat" => 1,
        }

        super(opts)
      end
    end
  end
end
