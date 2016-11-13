require_relative "../base_item"

module Greeve
  module Character
    # Character upcoming calendar events.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_upcomingcalendarevents.html
    class UpcomingCalendarEvents < Greeve::BaseItem
      endpoint "char/UpcomingCalendarEvents"

      rowset :upcoming_events, xpath: "eveapi/result/rowset[@name='upcomingEvents']" do
        attribute :event_id,      xpath: "@eventID",     type: :integer
        attribute :owner_id,      xpath: "@ownerID",     type: :integer
        attribute :owner_name,    xpath: "@ownerName",   type: :string
        attribute :owner_type_id, xpath: "@ownerTypeID", type: :integer
        attribute :event_date,    xpath: "@eventDate",   type: :datetime
        attribute :event_title,   xpath: "@eventTitle",  type: :string
        attribute :duration,      xpath: "@duration",    type: :integer
        attribute :importance,    xpath: "@importance",  type: :boolean
        attribute :response,      xpath: "@response",    type: :string
        attribute :event_text,    xpath: "@eventText",   type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
