require_relative "../base_item"

module Greeve
  module Character
    # Clones and basic attributes.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_clones.html
    class Clones < Greeve::BaseItem
      endpoint "char/Clones"

      attribute :dob,                 xpath:"eveapi/result/DoB/?[0]",               type: :datetime
      attribute :race,                xpath:"eveapi/result/race/?[0]",              type: :string
      attribute :bloodline_id,        xpath:"eveapi/result/bloodLineID/?[0]",       type: :integer
      attribute :bloodline,           xpath:"eveapi/result/bloodLine/?[0]",         type: :string
      attribute :ancestry_id,         xpath:"eveapi/result/ancestryID/?[0]",        type: :integer
      attribute :ancestry,            xpath:"eveapi/result/ancestry/?[0]",          type: :string
      attribute :gender,              xpath:"eveapi/result/gender/?[0]",            type: :string
      attribute :free_respecs,        xpath:"eveapi/result/freeRespecs/?[0]",       type: :integer
      attribute :clone_jump_date,     xpath:"eveapi/result/cloneJumpDate/?[0]",     type: :datetime
      attribute :last_respec_date,    xpath:"eveapi/result/lastRespecDate/?[0]",    type: :datetime
      attribute :last_timed_respec,   xpath:"eveapi/result/lastTimedRespec/?[0]",   type: :datetime
      attribute :remote_station_date, xpath:"eveapi/result/remoteStationDate/?[0]", type: :datetime
      attribute :jump_activation,     xpath:"eveapi/result/jumpActivation/?[0]",    type: :datetime
      attribute :jump_fatigue,        xpath:"eveapi/result/jumpFatigue/?[0]",       type: :datetime
      attribute :jump_last_update,    xpath:"eveapi/result/jumpLastUpdate/?[0]",    type: :datetime

      # Character attributes
      attribute :intelligence, xpath:"eveapi/result/attributes/intelligence/?[0]", type: :integer
      attribute :memory,       xpath:"eveapi/result/attributes/memory/?[0]",       type: :integer
      attribute :charisma,     xpath:"eveapi/result/attributes/charisma/?[0]",     type: :integer
      attribute :perception,   xpath:"eveapi/result/attributes/perception/?[0]",   type: :integer
      attribute :willpower,    xpath:"eveapi/result/attributes/willpower/?[0]",    type: :integer

      rowset :implants, xpath: "eveapi/result/rowset[@name='implants']" do
        attribute :type_id,   xpath: "@typeID",   type: :integer
        attribute :type_name, xpath: "@typeName", type: :string
      end

      rowset :jump_clones, xpath: "eveapi/result/rowset[@name='jumpClones']" do
        attribute :jump_clone_id, xpath: "@jumpCloneID", type: :integer
        attribute :type_id,       xpath: "@typeID",      type: :integer
        attribute :location_id,   xpath: "@locationID",  type: :integer
        attribute :clone_name,    xpath: "@cloneName",   type: :string
      end

      rowset :jump_clone_implants, xpath: "eveapi/result/rowset[@name='jumpCloneImplants']" do
        attribute :jump_clone_id, xpath: "@jumpCloneID", type: :integer
        attribute :type_id,       xpath: "@typeID",      type: :integer
        attribute :type_name,     xpath: "@typeName",    type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
