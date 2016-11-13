require_relative "../base_item"

module Greeve
  module Character
    # The header of eve mail messages sent to the character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_mailmessages.html
    class MailMessages < Greeve::BaseItem
      endpoint "char/MailMessages"

      rowset :messages, xpath: "eveapi/result/rowset[@name='messages']" do
        attribute :message_id,             xpath: "@messageID",          type: :integer
        attribute :sender_id,              xpath: "@senderID",           type: :integer
        attribute :sender_name,            xpath: "@senderName",         type: :string
        attribute :sent_date,              xpath: "@sentDate",           type: :datetime
        attribute :title,                  xpath: "@title",              type: :string
        attribute :to_corp_or_alliance_id, xpath: "@toCorpOrAllianceID", type: :integer
        attribute :to_character_ids,       xpath: "@toCharacterIDs",     type: :integer_array
        attribute :to_list_id,             xpath: "@toListID",           type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
