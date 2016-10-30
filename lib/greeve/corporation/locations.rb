require_relative "../base_item"

module Greeve
  module Corporation
    # Location of an item or character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_locations.html
    class Locations < Greeve::BaseItem
      endpoint "corp/Locations"

      rowset :locations, xpath: "eveapi/result/rowset[@name='locations']" do
        attribute :item_id,   xpath: "@itemID",   type: :integer
        attribute :item_name, xpath: "@itemName", type: :string
        attribute :x,         xpath: "@x",        type: :integer
        attribute :y,         xpath: "@y",        type: :integer
        attribute :z,         xpath: "@z",        type: :integer
      end

      # @param ids [Array<Integer>] IDs of items to retrieve location info for
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
