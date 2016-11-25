require_relative "../base_item"

module Greeve
  module Character
    # Bodies of eve mail messages sent to the character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_mailbodies.html
    class MailBodies < Greeve::BaseItem
      endpoint "char/MailBodies"

      rowset :messages, xpath: "eveapi/result/rowset[@name='messages']" do
        attribute :message_id, xpath: "@messageID", type: :integer
        attribute :message_text, xpath: "?[0]", type: :string
      end

      # @param character_id [Integer] EVE character ID
      # @param message_ids [*Array<Integer>, Integer] either a single message ID,
      #   or a list of message IDs
      #
      # @!method initialize(character_id, *message_ids, opts = {})
      def initialize(character_id, *message_ids)
        opts = message_ids.last.is_a?(Hash) ? message_ids.pop : {}

        opts[:query_params] = {
          "characterID" => character_id,
          "IDs" => message_ids.join(","),
        }

        super(opts)
      end
    end
  end
end
