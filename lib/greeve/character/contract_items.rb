require_relative "../base_item"

module Greeve
  module Character
    # Items and details of a particular contract.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_contractitems.html
    class ContractItems < Greeve::BaseItem
      endpoint "char/ContractItems"

      rowset :item_list, xpath: "eveapi/result/rowset[@name='itemList']" do
        attribute :record_id,    xpath: "@recordID",    type: :integer
        attribute :type_id,      xpath: "@typeID",      type: :integer
        attribute :quantity,     xpath: "@quantity",    type: :integer
        attribute :raw_quantity, xpath: "@rawQuantity", type: :integer
        attribute :singleton,    xpath: "@singleton",   type: :boolean
        attribute :included,     xpath: "@included",    type: :boolean
      end

      # @param character_id [Integer] EVE character ID
      # @param contract_id [Integer] ID of the contract
      def initialize(character_id, contract_id, opts = {})
        opts[:query_params] = {
          "characterID" => character_id,
          "contractID" => contract_id,
        }

        super(opts)
      end
    end
  end
end
