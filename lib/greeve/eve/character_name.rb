require_relative "../base_item"

module Greeve
  module Eve
    # Returns the names for a comma-separated list of owner IDs for characters,
    # corporations, alliances, etc.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_charactername.html
    class CharacterName < Greeve::BaseItem
      endpoint "eve/CharacterName"

      rowset :characters, xpath: "eveapi/result/rowset[@name='characters']" do
        attribute :name,         xpath: "@name",        type: :string
        attribute :character_id, xpath: "@characterID", type: :integer
      end

      # @param ids [Integer] EVE character IDs
      def initialize(ids, opts = {})
        opts[:query_params] = { "ids" => ids }
        super(opts)
      end
    end
  end
end
