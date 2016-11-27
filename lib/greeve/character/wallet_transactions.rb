require_relative "../base_item"

module Greeve
  module Character
    # Character wallet transactions.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_wallettransactions.html
    class WalletTransactions < Greeve::BaseItem
      endpoint "char/WalletTransactions"

      rowset :transactions, xpath: "eveapi/result/rowset[@name='transactions']" do
        attribute :transaction_date_time,  xpath: "@transactionDateTime",  type: :datetime
        attribute :transaction_id,         xpath: "@transactionID",        type: :integer
        attribute :quantity,               xpath: "@quantity",             type: :integer
        attribute :type_name,              xpath: "@typeName",             type: :string
        attribute :type_id,                xpath: "@typeID",               type: :integer
        attribute :price,                  xpath: "@price",                type: :numeric
        attribute :client_id,              xpath: "@clientID",             type: :integer
        attribute :client_name,            xpath: "@clientName",           type: :string
        attribute :station_id,             xpath: "@stationID",            type: :integer
        attribute :station_name,           xpath: "@stationName",          type: :string
        attribute :transaction_type,       xpath: "@transactionType",      type: :string
        attribute :transaction_for,        xpath: "@transactionFor",       type: :string
        attribute :journal_transaction_id, xpath: "@journalTransactionID", type: :integer
        attribute :client_type_id,         xpath: "@clientTypeID",         type: :integer
      end

      # @param character_id [Integer] EVE character ID
      #
      # @option opts [Integer] :from_id Optional upper bound for the transaction
      #   ID of returned transactions.
      # @option opts [Integer] :row_count Optional upper bound for the
      #   transaction ID of returned transactions. This argument is normally
      #   used to walk to the transaction log backwards.
      def initialize(character_id, opts = {})
        from_id = opts.delete(:from_id)
        row_count = opts.delete(:row_count)

        opts[:query_params] = { "characterID" => character_id }
        opts[:query_params]["fromID"] = from_id if from_id
        opts[:query_params]["rowCount"] = row_count if row_count

        super(opts)
      end
    end
  end
end
