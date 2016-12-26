require_relative "../base_item"

module Greeve
  module Eve
    # A list of transaction types used in the Corporation::WalletJournal
    # and Character::WalletJournal.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_reftypes.html
    class RefTypes < Greeve::BaseItem
      endpoint "eve/RefTypes"

      rowset :ref_types, xpath: "eveapi/result/rowset[@name='refTypes']" do
        attribute :ref_type_id,   xpath: "@refTypeID",   type: :integer
        attribute :ref_type_name, xpath: "@refTypeName", type: :string
      end
    end
  end
end
