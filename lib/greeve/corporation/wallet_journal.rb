require_relative "../base_item"

module Greeve
  module Corporation
    # Corporation wallet journal.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_walletjournal.html
    class WalletJournal < Greeve::BaseItem
      endpoint "corp/WalletJournal"

      rowset :entries, xpath: "eveapi/result/rowset[@name='entries']" do
        attribute :date,            xpath: "@date",         type: :datetime
        attribute :ref_id,          xpath: "@refID",        type: :integer
        attribute :ref_type_id,     xpath: "@refTypeID",    type: :integer
        attribute :owner_name_1,    xpath: "@ownerName1",   type: :string
        attribute :owner_id_1,      xpath: "@ownerID1",     type: :integer
        attribute :owner_name_2,    xpath: "@ownerName2",   type: :string
        attribute :owner_id_2,      xpath: "@ownerID2",     type: :integer
        attribute :arg_name_1,      xpath: "@argName1",     type: :string
        attribute :arg_id_1,        xpath: "@argID1",       type: :integer
        attribute :amount,          xpath: "@amount",       type: :numeric
        attribute :balance,         xpath: "@balance",      type: :numeric
        attribute :reason,          xpath: "@reason",       type: :string
        attribute :owner_1_type_id, xpath: "@owner1TypeID", type: :integer
        attribute :owner_2_type_id, xpath: "@owner2TypeID", type: :integer
      end

      # @option opts [Integer] :account_key account key of the wallet for which
      #   journal entries will be returned (1000 - 1006)
      # @option opts [Integer] :from_id upper bound for the ref_id of returned
      #   journal entries. Normally used to walk the journal backwards
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
