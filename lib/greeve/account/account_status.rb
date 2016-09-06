require_relative "../base_item"

module Greeve
  module Account
    # Information about a player’s EVE account like creation time, minutes spent
    # in game etc.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/account/account_accountstatus.html
    class AccountStatus < Greeve::BaseItem
      endpoint "account/AccountStatus"

      attribute :paid_until,    xpath: "eveapi/result/paidUntil/?[0]",    type: :datetime
      attribute :create_date,   xpath: "eveapi/result/createDate/?[0]",   type: :datetime
      attribute :logon_count,   xpath: "eveapi/result/logonCount/?[0]",   type: :integer
      attribute :logon_minutes, xpath: "eveapi/result/logonMinutes/?[0]", type: :integer

      rowset :multi_character_training, xpath: "eveapi/result/rowset[@name='multiCharacterTraining']" do
        attribute :training_end, xpath: "@trainingEnd", type: :datetime
      end
    end
  end
end
