require_relative "../base_item"

module Greeve
  module Eve
    # Retrieves character IDs based on names.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_characterid.html
    class CharacterID < Greeve::BaseItem
      endpoint "eve/CharacterID"

      rowset :characters, xpath: "eveapi/result/rowset[@name='characters']" do
        attribute :name,         xpath: "@name",        type: :string
        attribute :character_id, xpath: "@characterID", type: :integer
      end

      # @param names [Array<Integer>] names of characters
      #
      # @!method initialize(*names, opts = {})
      def initialize(*names)
        opts = names.last.is_a?(Hash) ? names.pop : {}

        opts[:query_params] = { "names" => names.join(",") }

        super(opts)
      end
    end
  end
end
