require_relative "../base_item"

module Greeve
  module Character
    # Character skill in training.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_skillintraining.html
    class SkillInTraining < Greeve::BaseItem
      endpoint "char/SkillInTraining"

      attribute :current_tq_time,         xpath: "eveapi/result/currentTQTime/?[0]",         type: :datetime
      attribute :training_end_time,       xpath: "eveapi/result/trainingEndTime/?[0]",       type: :datetime
      attribute :training_start_time,     xpath: "eveapi/result/trainingStartTime/?[0]",     type: :datetime
      attribute :training_type_id,        xpath: "eveapi/result/trainingTypeID/?[0]",        type: :integer
      attribute :training_start_sp,       xpath: "eveapi/result/trainingStartSP/?[0]",       type: :integer
      attribute :training_destination_sp, xpath: "eveapi/result/trainingDestinationSP/?[0]", type: :integer
      attribute :training_to_level,       xpath: "eveapi/result/trainingToLevel/?[0]",       type: :integer
      attribute :skill_in_training,       xpath: "eveapi/result/skillInTraining/?[0]",       type: :boolean

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
