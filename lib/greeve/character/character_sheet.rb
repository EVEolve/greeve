require_relative "../base_item"

module Greeve
  module Character
    # Character, skills and roles information.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_charactersheet.html
    class CharacterSheet < Greeve::BaseItem
      endpoint "char/CharacterSheet"

      attribute :character_id,        xpath: "eveapi/result/characterID/?[0]",       type: :integer
      attribute :name,                xpath: "eveapi/result/name/?[0]",              type: :string
      attribute :home_station_id,     xpath: "eveapi/result/homeStationID/?[0]",     type: :integer
      attribute :dob,                 xpath: "eveapi/result/DoB/?[0]",               type: :datetime
      attribute :race,                xpath: "eveapi/result/race/?[0]",              type: :string
      attribute :bloodline_id,        xpath: "eveapi/result/bloodLineID/?[0]",       type: :integer
      attribute :bloodline,           xpath: "eveapi/result/bloodLine/?[0]",         type: :string
      attribute :ancestry_id,         xpath: "eveapi/result/ancestryID/?[0]",        type: :integer
      attribute :ancestry,            xpath: "eveapi/result/ancestry/?[0]",          type: :string
      attribute :gender,              xpath: "eveapi/result/gender/?[0]",            type: :string
      attribute :corporation_name,    xpath: "eveapi/result/corporationName/?[0]",   type: :string
      attribute :corporation_id,      xpath: "eveapi/result/corporationID/?[0]",     type: :integer
      attribute :alliance_name,       xpath: "eveapi/result/allianceName/?[0]",      type: :string
      attribute :alliance_id,         xpath: "eveapi/result/allianceID/?[0]",        type: :integer
      attribute :faction_name,        xpath: "eveapi/result/factionName/?[0]",       type: :string
      attribute :faction_id,          xpath: "eveapi/result/factionID/?[0]",         type: :integer
      attribute :clone_type_id,       xpath: "eveapi/result/cloneTypeID/?[0]",       type: :integer
      attribute :clone_name,          xpath: "eveapi/result/cloneName/?[0]",         type: :string
      attribute :clone_skill_points,  xpath: "eveapi/result/cloneSkillPoints/?[0]",  type: :integer
      attribute :free_skill_points,   xpath: "eveapi/result/freeSkillPoints/?[0]",   type: :integer
      attribute :free_respecs,        xpath: "eveapi/result/freeRespecs/?[0]",       type: :integer
      attribute :clone_jump_date,     xpath: "eveapi/result/cloneJumpDate/?[0]",     type: :datetime
      attribute :last_respec_date,    xpath: "eveapi/result/lastRespecDate/?[0]",    type: :datetime
      attribute :last_timed_respec,   xpath: "eveapi/result/lastTimedRespec/?[0]",   type: :datetime
      attribute :remote_station_date, xpath: "eveapi/result/remoteStationDate/?[0]", type: :datetime
      attribute :jump_activation,     xpath: "eveapi/result/jumpActivation/?[0]",    type: :datetime
      attribute :jump_fatigue,        xpath: "eveapi/result/jumpFatigue/?[0]",       type: :datetime
      attribute :jump_last_update,    xpath: "eveapi/result/jumpLastUpdate/?[0]",    type: :datetime
      attribute :balance,             xpath: "eveapi/result/balance/?[0]",           type: :numeric

      # Character attributes
      attribute :intelligence, xpath: "eveapi/result/attributes/intelligence/?[0]", type: :integer
      attribute :memory,       xpath: "eveapi/result/attributes/memory/?[0]",       type: :integer
      attribute :charisma,     xpath: "eveapi/result/attributes/charisma/?[0]",     type: :integer
      attribute :perception,   xpath: "eveapi/result/attributes/perception/?[0]",   type: :integer
      attribute :willpower,    xpath: "eveapi/result/attributes/willpower/?[0]",    type: :integer

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

      rowset :skills, xpath: "eveapi/result/rowset[@name='skills']" do
        attribute :type_id,     xpath: "@typeID",      type: :integer
        attribute :skillpoints, xpath: "@skillpoints", type: :integer
        attribute :level,       xpath: "@level",       type: :integer
        attribute :published,   xpath: "@published",   type: :boolean
      end

      rowset :certificates, xpath: "eveapi/result/rowset[@name='certificates']" do
        attribute :certificate_id, xpath: "@certificateID", type: :integer
      end

      rowset :corporation_roles, xpath: "eveapi/result/rowset[@name='corporationRoles']" do
        attribute :role_id,   xpath: "@roleID",   type: :integer
        attribute :role_name, xpath: "@roleName", type: :string
      end

      rowset :corporation_roles_at_hq, xpath: "eveapi/result/rowset[@name='corporationRolesAtHQ']" do
        attribute :role_id,   xpath: "@roleID",   type: :integer
        attribute :role_name, xpath: "@roleName", type: :string
      end

      rowset :corporation_roles_at_base, xpath: "eveapi/result/rowset[@name='corporationRolesAtBase']" do
        attribute :role_id,   xpath: "@roleID",   type: :integer
        attribute :role_name, xpath: "@roleName", type: :string
      end

      rowset :corporation_roles_at_other, xpath: "eveapi/result/rowset[@name='corporationRolesAtOther']" do
        attribute :role_id,   xpath: "@roleID",   type: :integer
        attribute :role_name, xpath: "@roleName", type: :string
      end

      rowset :corporation_titles, xpath: "eveapi/result/rowset[@name='corporationTitles']" do
        attribute :title_id,   xpath: "@titleID",   type: :integer
        attribute :title_name, xpath: "@titleName", type: :string
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
