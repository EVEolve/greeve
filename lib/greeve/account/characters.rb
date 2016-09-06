require_relative "../base_item"

module Greeve
  module Account
    # Lists all characters for an API key.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/account/account_characters.html
    class Characters < Greeve::BaseItem
      endpoint "account/Characters"

      rowset :characters, xpath: "eveapi/result/rowset[@name='characters']" do
        attribute :name,             xpath: "@name",            type: :string
        attribute :character_id,     xpath: "@characterID",     type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :alliance_name,    xpath: "@allianceName",    type: :string
        attribute :alliance_id,      xpath: "@allianceID",      type: :integer
        attribute :faction_name,     xpath: "@factionName",     type: :string
        attribute :faction_id,       xpath: "@factionID",       type: :integer
      end
    end
  end
end
