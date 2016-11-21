require_relative "../base_item"

module Greeve
  module Character
    # The character’s personal, corporation, and alliance contacts.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_contactlist.html
    class ContactList < Greeve::BaseItem
      endpoint "char/ContactList"

      rowset :contact_list, xpath: "eveapi/result/rowset[@name='contactList']" do
        attribute :contact_id,      xpath: "@contactID",     type: :integer
        attribute :contact_name,    xpath: "@contactName",   type: :string
        attribute :standing,        xpath: "@standing",      type: :integer
        attribute :contact_type_id, xpath: "@contactTypeID", type: :integer
        attribute :label_mask,      xpath: "@labelMask",     type: :integer
        attribute :in_watchlist,    xpath: "@inWatchlist",   type: :boolean
      end

      rowset :contact_labels, xpath: "eveapi/result/rowset[@name='contactLabels']" do
        attribute :label_id, xpath: "@labelID", type: :integer
        attribute :name,     xpath: "@name",    type: :string
      end

      rowset :corporate_contact_list, xpath: "eveapi/result/rowset[@name='corporateContactList']" do
        attribute :contact_id,      xpath: "@contactID",     type: :integer
        attribute :contact_name,    xpath: "@contactName",   type: :string
        attribute :standing,        xpath: "@standing",      type: :integer
        attribute :contact_type_id, xpath: "@contactTypeID", type: :integer
        attribute :label_mask,      xpath: "@labelMask",     type: :integer
      end

      rowset :corporate_contact_labels, xpath: "eveapi/result/rowset[@name='corporateContactLabels']" do
        attribute :label_id, xpath: "@labelID", type: :integer
        attribute :name,     xpath: "@name",    type: :string
      end

      rowset :alliance_contact_list, xpath: "eveapi/result/rowset[@name='allianceContactList']" do
        attribute :contact_id,      xpath: "@contactID",     type: :integer
        attribute :contact_name,    xpath: "@contactName",   type: :string
        attribute :standing,        xpath: "@standing",      type: :integer
        attribute :contact_type_id, xpath: "@contactTypeID", type: :integer
        attribute :label_mask,      xpath: "@labelMask",     type: :integer
      end

      rowset :alliance_contact_labels, xpath: "eveapi/result/rowset[@name='allianceContactLabels']" do
        attribute :label_id, xpath: "@labelID", type: :integer
        attribute :name,     xpath: "@name",    type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
