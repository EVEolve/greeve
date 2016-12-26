require_relative "../base_item"

module Greeve
  module Eve
    # Corporations, alliances, and factions the character(s) are members of.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_characteraffiliation.html
    class CharacterAffiliation < Greeve::BaseItem
      endpoint "eve/CharacterAffiliation"

      rowset :characters, xpath: "eveapi/result/rowset[@name='characters']" do
        attribute :character_id,     xpath: "@characterID",     type: :integer
        attribute :character_name,   xpath: "@characterName",   type: :string
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :alliance_id,      xpath: "@allianceID",      type: :integer
        attribute :alliance_name,    xpath: "@allianceName",    type: :string
        attribute :faction_id,       xpath: "@factionID",       type: :integer
        attribute :faction_name,     xpath: "@factionName",     type: :string
      end

      # @param ids [Array<Integer>] IDs of characters
      #
      # @!method initialize(*ids, opts = {})
      def initialize(*ids)
        opts = ids.last.is_a?(Hash) ? ids.pop : {}

        opts[:query_params] = { "IDs" => ids.join(",") }

        super(opts)
      end
    end
  end
end
