require_relative "../base_item"

module Greeve
  module Character
    # Character account balance.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_accountbalance.html
    class AccountBalance < Greeve::BaseItem
      endpoint "char/AccountBalance"

      rowset :accounts, xpath: "eveapi/result/rowset[@name='accounts']" do
        attribute :account_id,  xpath: "@accountID",  type: :integer
        attribute :account_key, xpath: "@accountKey", type: :integer
        attribute :balance,     xpath: "@balance",    type: :numeric
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
