require_relative "../base_item"

module Greeve
  module Account
    # Represents the access rights of an API key.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/account/account_apikeyinfo.html
    class APIKeyInfo < Greeve::BaseItem
      endpoint "account/APIKeyInfo"

      attribute :access_mask, xpath: "eveapi/result/key/@accessMask", type: :integer
      attribute :type,        xpath: "eveapi/result/key/@type",       type: :string
      attribute :expires,     xpath: "eveapi/result/key/@expires",    type: :datetime

      rowset :characters, xpath: "eveapi/result/key/rowset[@name='characters']" do
        attribute :character_id,     xpath: "@characterID",     type: :integer
        attribute :character_name,   xpath: "@characterName",   type: :string
        attribute :corporation_id,   xpath: "@corporationID",   type: :integer
        attribute :corporation_name, xpath: "@corporationName", type: :string
        attribute :alliance_id,      xpath: "@allianceID",      type: :integer
        attribute :alliance_name,    xpath: "@allianceName",    type: :string
        attribute :faction_id,       xpath: "@factionID",       type: :integer
        attribute :faction_name,     xpath: "@factionName",     type: :string
      end
    end
  end
end
