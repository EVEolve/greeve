require_relative "../base_item"

module Greeve
  module Eve
    # Public character info.
    class CharacterInfo < Greeve::BaseItem
      endpoint "eve/CharacterInfo"

      attribute :character_id,        xpath: "eveapi/result/characterID/?[0]",       type: :integer
      attribute :character_name,      xpath: "eveapi/result/characterName/?[0]",     type: :string
      attribute :race,                xpath: "eveapi/result/race/?[0]",              type: :string
      attribute :bloodline_id,        xpath: "eveapi/result/bloodlineID/?[0]",       type: :integer
      attribute :bloodline,           xpath: "eveapi/result/bloodline/?[0]",         type: :string
      attribute :ancestry_id,         xpath: "eveapi/result/ancestryID/?[0]",        type: :integer
      attribute :ancestry,            xpath: "eveapi/result/ancestry/?[0]",          type: :string
      attribute :account_balance,     xpath: "eveapi/result/accountBalance/?[0]",    type: :numeric
      attribute :skill_points,        xpath: "eveapi/result/skillPoints/?[0]",       type: :integer
      attribute :next_training_ends,  xpath: "eveapi/result/nextTrainingEnds/?[0]",  type: :datetime
      attribute :ship_name,           xpath: "eveapi/result/shipName/?[0]",          type: :string
      attribute :ship_type_id,        xpath: "eveapi/result/shipTypeID/?[0]",        type: :integer
      attribute :ship_type_name,      xpath: "eveapi/result/shipTypeName/?[0]",      type: :string
      attribute :corporation_id,      xpath: "eveapi/result/corporationID/?[0]",     type: :integer
      attribute :corporation,         xpath: "eveapi/result/corporation/?[0]",       type: :string
      attribute :corporation_date,    xpath: "eveapi/result/corporationDate/?[0]",   type: :datetime
      attribute :alliance_id,         xpath: "eveapi/result/allianceID/?[0]",        type: :integer
      attribute :alliance,            xpath: "eveapi/result/alliance/?[0]",          type: :string
      attribute :alliance_date,       xpath: "eveapi/result/allianceDate/?[0]",      type: :datetime
      attribute :last_known_location, xpath: "eveapi/result/lastKnownLocation/?[0]", type: :string
      attribute :security_status,     xpath: "eveapi/result/securityStatus/?[0]",    type: :numeric

      rowset :employment_history, xpath: "eveapi/result/rowset[@name='employmentHistory']" do
        attribute :record_id,        xpath: "@recordID",        type: :integer
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :start_date,       xpath: "@startDate",       type: :datetime
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
