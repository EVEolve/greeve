require_relative "../base_item"

module Greeve
  module Character
    # Character notification bodies.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_notificationtexts.html
    class NotificationTexts < Greeve::BaseItem
      endpoint "char/NotificationTexts"

      rowset :notifications, xpath: "eveapi/result/rowset[@name='notifications']" do
        attribute :notification_id,   xpath: "@notificationID", type: :integer
        attribute :notification_text, xpath: "?[0]",            type: :string
      end

      # @param character_id [Integer] EVE character ID
      # @param ids [Array<Integer>, Integer] IDs of items to retrieve location
      #   info for
      #
      # @!method initialize(*ids, opts = {})
      def initialize(character_id, *ids)
        opts = ids.last.is_a?(Hash) ? ids.pop : {}

        opts[:query_params] = {
          "characterID" => character_id,
          "IDs" => ids.join(","),
        }

        super(opts)
      end
    end
  end
end
