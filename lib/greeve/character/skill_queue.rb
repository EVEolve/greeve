require_relative "../base_item"

module Greeve
  module Character
    # Character skill queue.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_skillqueue.html
    class SkillQueue < Greeve::BaseItem
      endpoint "char/SkillQueue"

      rowset :skillqueue, xpath: "eveapi/result/rowset[@name='skillqueue']" do
        attribute :queue_position, xpath: "@queuePosition", type: :integer
        attribute :type_id,        xpath: "@typeID",        type: :integer
        attribute :level,          xpath: "@level",         type: :integer
        attribute :start_sp,       xpath: "@startSP",       type: :integer
        attribute :end_sp,         xpath: "@endSP",         type: :integer
        attribute :start_time,     xpath: "@startTime",     type: :datetime
        attribute :end_time,       xpath: "@endTime",       type: :datetime
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
