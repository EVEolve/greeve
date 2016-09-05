require_relative "../base_item"

module Greeve
  module Character
    # Known skills of a character.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_skills.html
    class Skills < Greeve::BaseItem
      endpoint "char/Skills"

      attribute :free_skill_points, xpath: "eveapi/result/freeSkillPoints/?[0]", type: :integer

      rowset :skills, xpath: "eveapi/result/rowset[@name='skills']" do
        attribute :type_id,     xpath: "@typeID",      type: :integer
        attribute :type_name,   xpath: "@typeName",    type: :string
        attribute :skillpoints, xpath: "@skillpoints", type: :integer
        attribute :level,       xpath: "@level",       type: :integer
        attribute :published,   xpath: "@published",   type: :boolean
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
