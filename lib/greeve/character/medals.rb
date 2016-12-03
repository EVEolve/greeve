require_relative "../base_item"

module Greeve
  module Character
    # Medals the character has received.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_medals.html
    class Medals < Greeve::BaseItem
      endpoint "char/Medals"

      rowset :current_corporation, xpath: "eveapi/result/rowset[@name='currentCorporation']" do
        attribute :medal_id,       xpath: "@medalID",       type: :integer
        attribute :reason,         xpath: "@reason",        type: :string
        attribute :status,         xpath: "@status",        type: :string
        attribute :issuer_id,      xpath: "@issuerID",      type: :integer
        attribute :issued,         xpath: "@issued",        type: :datetime
        attribute :corporation_id, xpath: "@corporationID", type: :integer
        attribute :title,          xpath: "@title",         type: :string
        attribute :description,    xpath: "@description",   type: :string
      end

      rowset :other_corporations, xpath: "eveapi/result/rowset[@name='otherCorporations']" do
        attribute :medal_id,       xpath: "@medalID",       type: :integer
        attribute :reason,         xpath: "@reason",        type: :string
        attribute :status,         xpath: "@status",        type: :string
        attribute :issuer_id,      xpath: "@issuerID",      type: :integer
        attribute :issued,         xpath: "@issued",        type: :datetime
        attribute :corporation_id, xpath: "@corporationID", type: :integer
        attribute :title,          xpath: "@title",         type: :string
        attribute :description,    xpath: "@description",   type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
