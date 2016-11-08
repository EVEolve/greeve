require_relative "../base_item"

module Greeve
  module Corporation
    # Details for a starbase.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_starbasedetail.html
    class StarbaseDetail < Greeve::BaseItem
      endpoint "corp/StarbaseDetail"

      attribute :state,            xpath: "eveapi/result/state/?[0]",           type: :integer
      attribute :state_timestamp,  xpath: "eveapi/result/stateTimestamp/?[0]",  type: :datetime
      attribute :online_timestamp, xpath: "eveapi/result/onlineTimestamp/?[0]", type: :datetime

      # General Settings
      attribute :usage_flags,               xpath: "eveapi/result/generalSettings/usageFlags/?[0]",              type: :integer
      attribute :deploy_flags,              xpath: "eveapi/result/generalSettings/deployFlags/?[0]",             type: :integer
      attribute :allow_corporation_members, xpath: "eveapi/result/generalSettings/allowCorporationMembers/?[0]", type: :boolean
      attribute :allow_alliance_members,    xpath: "eveapi/result/generalSettings/allowAllianceMembers/?[0]",    type: :boolean

      # Combat Settings
      attribute :use_standings_from_owner_id, xpath: "eveapi/result/combatSettings/useStandingsFrom/@ownerID", type: :integer
      attribute :on_standing_drop_standing,   xpath: "eveapi/result/combatSettings/onStandingDrop/@standing",  type: :integer
      attribute :on_status_drop_enabled,      xpath: "eveapi/result/combatSettings/onStatusDrop/@enabled",     type: :boolean
      attribute :on_status_drop_standing,     xpath: "eveapi/result/combatSettings/onStatusDrop/@standing",    type: :integer
      attribute :on_aggression_enabled,       xpath: "eveapi/result/combatSettings/onAggression/@enabled",     type: :boolean
      attribute :on_corporation_war_enabled,  xpath: "eveapi/result/combatSettings/onCorporationWar/@enabled", type: :boolean

      rowset :fuel, xpath: "eveapi/result/rowset[@name='fuel']" do
        attribute :type_id,  xpath: "@typeID",   type: :integer
        attribute :quantity, xpath: "@quantity", type: :integer
      end

      # @param item_id [Integer] ID of the POS as given in the {StarbaseList}
      def initialize(item_id, opts = {})
        opts[:query_params] = { "itemID" => item_id }

        super(opts)
      end
    end
  end
end
