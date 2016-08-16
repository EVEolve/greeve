require_relative "../base_item"

module Greeve
  module Eve
    # Public character info.
    class CharacterInfo < Greeve::BaseItem
      endpoint "eve/CharacterInfo"

      attribute :character_id,     xpath: "characterID/?[0]",     type: :integer
      attribute :character_name,   xpath: "characterName/?[0]",   type: :string
      attribute :race,             xpath: "race/?[0]",            type: :string
      attribute :bloodline_id,     xpath: "bloodlineID/?[0]",     type: :integer
      attribute :bloodline,        xpath: "bloodline/?[0]",       type: :string
      attribute :ancestry_id,      xpath: "ancestryID/?[0]",      type: :integer
      attribute :ancestry,         xpath: "ancestry/?[0]",        type: :string
      attribute :corporation_id,   xpath: "corporationID/?[0]",   type: :integer
      attribute :corporation,      xpath: "corporation/?[0]",     type: :string
      attribute :corporation_date, xpath: "corporationDate/?[0]", type: :string
      attribute :security_status,  xpath: "securityStatus/?[0]",  type: :numeric
    end

    # @param character_id [Integer] EVE character ID
    def initialize(character_id)
      super(query_params: {
        "characterID" => character_id,
      })
    end
  end
end
