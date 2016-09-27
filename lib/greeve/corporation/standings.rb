require_relative "../base_item"

module Greeve
  module Corporation
    # Standings that non-player entities have to the corporation.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_standings.html
    class Standings < Greeve::BaseItem
      endpoint "corp/Standings"

      rowset :agents, xpath: "eveapi/result/corporationNPCStandings/rowset[@name='agents']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end

      rowset :npc_corporations, xpath: "eveapi/result/corporationNPCStandings/rowset[@name='NPCCorporations']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end

      rowset :factions, xpath: "eveapi/result/corporationNPCStandings/rowset[@name='factions']" do
        attribute :from_id,   xpath: "@fromID",   type: :integer
        attribute :from_name, xpath: "@fromName", type: :string
        attribute :standing,  xpath: "@standing", type: :numeric
      end
    end
  end
end
