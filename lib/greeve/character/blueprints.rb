require_relative "../base_item"

module Greeve
  module Character
    # Blueprints in a character's inventory.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_blueprints.html
    class Blueprints < Greeve::BaseItem
      # Blueprint original
      BPO = -1
      # Blueprint copy
      BPC = -2

      endpoint "char/Blueprints"

      rowset :blueprints, xpath: "eveapi/result/rowset[@name='blueprints']" do
        attribute :item_id,             xpath: "@itemID",             type: :integer
        attribute :location_id,         xpath: "@locationID",         type: :integer
        attribute :type_id,             xpath: "@typeID",             type: :integer
        attribute :type_name,           xpath: "@typeName",           type: :string
        attribute :quantity,            xpath: "@quantity",           type: :integer
        attribute :flag_id,             xpath: "@flagID",             type: :integer
        attribute :time_efficiency,     xpath: "@timeEfficiency",     type: :integer
        attribute :material_efficiency, xpath: "@materialEfficiency", type: :integer
        attribute :runs,                xpath: "@runs",               type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
