require_relative "../base_item"

module Greeve
  module Character
    # Character notifications.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_notifications.html
    class Notifications < Greeve::BaseItem
      endpoint "char/Notifications"

      rowset :notifications, xpath: "eveapi/result/rowset[@name='notifications']" do
        attribute :notification_id, xpath: "@notificationID", type: :integer
        attribute :type_id,         xpath: "@typeID",         type: :integer
        attribute :sender_id,       xpath: "@senderID",       type: :integer
        attribute :sender_name,     xpath: "@senderName",     type: :string
        attribute :sent_date,       xpath: "@sentDate",       type: :datetime
        attribute :read,            xpath: "@read",           type: :boolean
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
