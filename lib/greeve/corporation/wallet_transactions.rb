require_relative "../base_item"

module Greeve
  module Corporation
    # Corporation wallet transactions.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_wallettransactions.html
    class WalletTransactions < Greeve::BaseItem
      endpoint "corp/WalletTransactions"

      rowset :transactions, xpath: "eveapi/result/rowset[@name='transactions']" do
        attribute :transaction_date_time,  xpath: "@transactionDateTime",  type: :datetime
        attribute :transaction_id,         xpath: "@transactionID",        type: :integer
        attribute :quantity,               xpath: "@quantity",             type: :integer
        attribute :type_name,              xpath: "@typeName",             type: :string
        attribute :type_id,                xpath: "@typeID",               type: :integer
        attribute :price,                  xpath: "@price",                type: :numeric
        attribute :client_id,              xpath: "@clientID",             type: :integer
        attribute :client_name,            xpath: "@clientName",           type: :string
        attribute :character_id,           xpath: "@characterID",          type: :integer
        attribute :character_name,         xpath: "@characterName",        type: :string
        attribute :station_id,             xpath: "@stationID",            type: :integer
        attribute :station_name,           xpath: "@stationName",          type: :string
        attribute :transaction_type,       xpath: "@transactionType",      type: :string
        attribute :transaction_for,        xpath: "@transactionFor",       type: :string
        attribute :journal_transaction_id, xpath: "@journalTransactionID", type: :integer
        attribute :client_type_id,         xpath: "@clientTypeID",         type: :integer
      end

      # @option opts [Integer] :account_key account key of the wallet for which
      #   transactions will be returned (1000 - 1006)
      # @option opts [Integer] :from_id upper bound for the ref_id of returned
      #   transactions. Normally used to walk the transaction log backwards
      # @option opts [Integer] :row_count limit on the number of rows to return.
      #   Default is 1000, max is 2560
      def initialize(opts = {})
        account_key = opts[:account_key]
        from_id = opts[:from_id]
        row_count = opts[:row_count]

        opts[:query_params] = {}
        opts[:query_params]["accountKey"] = account_key if account_key
        opts[:query_params]["fromID"] = from_id if from_id
        opts[:query_params]["rowCount"] = row_count if row_count

        super(opts)
      end
    end
  end
end
