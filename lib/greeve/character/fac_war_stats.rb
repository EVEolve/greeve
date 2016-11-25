require_relative "../base_item"

module Greeve
  module Character
    # Faction warfare information for characters enrolled in faction warfare.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_facwarstats.html
    class FacWarStats < Greeve::BaseItem
      endpoint "char/FacWarStats"

      attribute :faction_id,               xpath: "eveapi/result/factionID/?[0]",              type: :integer
      attribute :faction_name,             xpath: "eveapi/result/factionName/?[0]",            type: :string
      attribute :enlisted,                 xpath: "eveapi/result/enlisted/?[0]",               type: :datetime
      attribute :current_rank,             xpath: "eveapi/result/currentRank/?[0]",            type: :integer
      attribute :highest_rank,             xpath: "eveapi/result/highestRank/?[0]",            type: :integer
      attribute :kills_yesterday,          xpath: "eveapi/result/killsYesterday/?[0]",         type: :integer
      attribute :kills_last_week,          xpath: "eveapi/result/killsLastWeek/?[0]",          type: :integer
      attribute :kills_total,              xpath: "eveapi/result/killsTotal/?[0]",             type: :integer
      attribute :victory_points_yesterday, xpath: "eveapi/result/victoryPointsYesterday/?[0]", type: :integer
      attribute :victory_points_last_week, xpath: "eveapi/result/victoryPointsLastWeek/?[0]",  type: :integer
      attribute :victory_points_total,     xpath: "eveapi/result/victoryPointsTotal/?[0]",     type: :integer

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
