require_relative "../base_item"

module Greeve
  module Character
    # Notifications received when having been added to someone’s contact list.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_contactnotifications.html
    class ContactNotifications < Greeve::BaseItem
      endpoint "char/ContactNotifications"

      rowset :contact_notifications, xpath: "eveapi/result/rowset[@name='contactNotifications']" do
        attribute :notification_id, xpath: "@notificationID", type: :integer
        attribute :sender_id,       xpath: "@senderID",       type: :integer
        attribute :sender_name,     xpath: "@senderName",     type: :string
        attribute :sent_date,       xpath: "@sentDate",       type: :datetime
        attribute :message_data,    xpath: "@messageData",    type: :hash
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
