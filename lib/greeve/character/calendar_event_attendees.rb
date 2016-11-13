require_relative "../base_item"

module Greeve
  module Character
    # A list of all invited attendees for a given event.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_calendareventattendees.html
    class CalendarEventAttendees < Greeve::BaseItem
      endpoint "char/CalendarEventAttendees"

      rowset :event_attendees, xpath: "eveapi/result/rowset[@name='eventAttendees']" do
        attribute :event_id,       xpath: "@eventID",       type: :integer
        attribute :character_id,   xpath: "@characterID",   type: :integer
        attribute :character_name, xpath: "@characterName", type: :string
        attribute :response,       xpath: "@response",      type: :string
      end

      # @param character_id [Integer] EVE character ID
      # @param event_ids [Array<Integer>, Integer] either a single event ID, or
      #   an array of event IDs
      def initialize(character_id, event_ids, opts = {})
        event_ids = [event_ids] unless event_ids.is_a?(Array)

        opts[:query_params] = {
          "characterID" => character_id,
          "eventIDs" => event_ids.join(",")
        }

        super(opts)
      end
    end
  end
end
