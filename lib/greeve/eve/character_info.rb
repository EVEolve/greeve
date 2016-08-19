require_relative "../base_item"

module Greeve
  module Eve
    # Public character info.
    class CharacterInfo < Greeve::BaseItem
      endpoint "eve/CharacterInfo"

      attribute :character_id,     xpath: "eveapi/result/characterID/?[0]",     type: :integer
      attribute :character_name,   xpath: "eveapi/result/characterName/?[0]",   type: :string
      attribute :race,             xpath: "eveapi/result/race/?[0]",            type: :string
      attribute :bloodline_id,     xpath: "eveapi/result/bloodlineID/?[0]",     type: :integer
      attribute :bloodline,        xpath: "eveapi/result/bloodline/?[0]",       type: :string
      attribute :ancestry_id,      xpath: "eveapi/result/ancestryID/?[0]",      type: :integer
      attribute :ancestry,         xpath: "eveapi/result/ancestry/?[0]",        type: :string
      attribute :corporation_id,   xpath: "eveapi/result/corporationID/?[0]",   type: :integer
      attribute :corporation,      xpath: "eveapi/result/corporation/?[0]",     type: :string
      attribute :corporation_date, xpath: "eveapi/result/corporationDate/?[0]", type: :datetime
      attribute :security_status,  xpath: "eveapi/result/securityStatus/?[0]",  type: :numeric

      rowset :employment_history, xpath: "eveapi/result/rowset[@name='employmentHistory']" do
        attribute :record_id,        xpath: "@recordID",        type: :integer
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :start_date,       xpath: "@startDate",       type: :datetime
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id)
        super(query_params: {
          "characterID" => character_id,
        })
      end
    end
  end
end
