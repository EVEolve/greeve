require_relative "../base_item"

module Greeve
  module Character
    # Character wallet journal.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_walletjournal.html
    class WalletJournal < Greeve::BaseItem
      endpoint "char/WalletJournal"

      rowset :transactions, xpath: "eveapi/result/rowset[@name='transactions']" do
        attribute :date,            xpath: "@date",          type: :datetime
        attribute :ref_id,          xpath: "@refID",         type: :integer
        attribute :ref_type_id,     xpath: "@refTypeID",     type: :integer
        attribute :owner_name_1,    xpath: "@ownerName1",    type: :string
        attribute :owner_id_1,      xpath: "@ownerID1",      type: :integer
        attribute :owner_name_2,    xpath: "@ownerName2",    type: :string
        attribute :owner_id_2,      xpath: "@ownerID2",      type: :integer
        attribute :arg_name_1,      xpath: "@argName1",      type: :string
        attribute :arg_id_1,        xpath: "@argID1",        type: :integer
        attribute :amount,          xpath: "@amount",        type: :numeric
        attribute :balance,         xpath: "@balance",       type: :numeric
        attribute :reason,          xpath: "@reason",        type: :string
        attribute :tax_receiver_id, xpath: "@taxReceiverID", type: :integer
        attribute :tax_amount,      xpath: "@taxAmount",     type: :numeric
        attribute :owner_1_type_id, xpath: "@owner1TypeID",  type: :integer
        attribute :owner_2_type_id, xpath: "@owner2TypeID",  type: :integer
      end

      # @param character_id [Integer] EVE character ID
      #
      # @option opts [Integer] :from_id Optional upper bound for the ref ID of
      #   returned journal entries. This argument is normally used to walk to
      #   the journal backwards.
      # @option opts [Integer] :row_count Optional limit on number of rows to
      #   return. Default is 1000. Maximum is 2560.
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
