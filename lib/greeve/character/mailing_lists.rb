require_relative "../base_item"

module Greeve
  module Character
    # Mailing lists the character is a member of.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_mailinglists.html
    class MailingLists < Greeve::BaseItem
      endpoint "char/MailingLists"

      rowset :mailing_lists, xpath: "eveapi/result/rowset[@name='mailingLists']" do
        attribute :list_id,      xpath: "@listID",      type: :integer
        attribute :display_name, xpath: "@displayName", type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
