require_relative "../base_item"

module Greeve
  module Corporation
    # Corporation account balances.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_accountbalance.html
    class AccountBalance < Greeve::BaseItem
      endpoint "corp/AccountBalance"

      rowset :accounts, xpath: "eveapi/result/rowset[@name='accounts']" do
        attribute :account_id,  xpath: "@accountID",  type: :integer
        attribute :account_key, xpath: "@accountKey", type: :integer
        attribute :balance,     xpath: "@balance",    type: :numeric
      end
    end
  end
end
