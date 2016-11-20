require_relative "../base_item"

module Greeve
  module Character
    # Location and name of specific items that belong to the character of the
    # api key. This call can be used to retrieve the player-set name of
    # containers and ships.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_locations.html
    class Locations < Greeve::BaseItem
      endpoint "char/Locations"

      rowset :locations, xpath: "eveapi/result/rowset[@name='locations']" do
        attribute :item_id,   xpath: "@itemID",   type: :integer
        attribute :item_name, xpath: "@itemName", type: :string
        attribute :x,         xpath: "@x",        type: :numeric
        attribute :y,         xpath: "@y",        type: :numeric
        attribute :z,         xpath: "@z",        type: :numeric
      end

      # @param character_id [Integer] EVE character ID
      #
      # @option opts [Array<Integer>, Integer] :ids (nil) ID or array of IDs of
      #   items belonging to the character
      def initialize(character_id, opts = {})
        ids = opts.delete(:ids)
        ids = [ids] unless ids.nil? || ids.is_a?(Array)

        opts[:query_params] = { "characterID" => character_id }
        opts[:query_params]["IDs"] = ids.join(",") if ids

        super(opts)
      end
    end
  end
end
