require_relative "../base_item"

module Greeve
  module Character
    # Character standings (does not take character skills into account).
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_standings.html
    class Standings < Greeve::BaseItem
      endpoint "eve/Standings"

      rowset :agents, xpath: "eveapi/result/characterNPCStandings/rowset[@name='agents']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end

      rowset :npc_corporations, xpath: "eveapi/result/characterNPCStandings/rowset[@name='NPCCorporations']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end

      rowset :factions, xpath: "eveapi/result/characterNPCStandings/rowset[@name='factions']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
