require_relative "../base_item"

module Greeve
  module Character
    # Character research.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_research.html
    class Research < Greeve::BaseItem
      endpoint "char/Research"

      rowset :research, xpath: "eveapi/result/rowset[@name='research']" do
        attribute :agent_id,            xpath: "@agentID",           type: :integer
        attribute :skill_type_id,       xpath: "@skillTypeID",       type: :integer
        attribute :research_start_date, xpath: "@researchStartDate", type: :datetime
        attribute :points_per_day,      xpath: "@pointsPerDay",      type: :numeric
        attribute :remainder_points,    xpath: "@remainderPoints",   type: :numeric
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
