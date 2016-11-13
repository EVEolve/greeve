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

      namespace :general_settings, xpath: "eveapi/result/generalSettings" do
        attribute :usage_flags,               xpath: "usageFlags/?[0]",              type: :integer
        attribute :deploy_flags,              xpath: "deployFlags/?[0]",             type: :integer
        attribute :allow_corporation_members, xpath: "allowCorporationMembers/?[0]", type: :boolean
        attribute :allow_alliance_members,    xpath: "allowAllianceMembers/?[0]",    type: :boolean
      end

      namespace :combat_settings, xpath: "eveapi/result/combatSettings" do
        namespace :use_standings_from, xpath: "useStandingsFrom" do
          attribute :owner_id, xpath: "@ownerID", type: :integer
        end

        namespace :on_standing_drop, xpath: "onStandingDrop" do
          attribute :standing, xpath: "@standing", type: :integer
        end

        namespace :on_status_drop, xpath: "onStatusDrop" do
          attribute :enabled,  xpath: "@enabled",  type: :boolean
          attribute :standing, xpath: "@standing", type: :integer
        end

        namespace :on_aggression, xpath: "onAggression" do
          attribute :enabled, xpath: "@enabled", type: :boolean
        end

        namespace :on_corporation_war, xpath: "onCorporationWar" do
          attribute :enabled, xpath: "@enabled", type: :boolean
        end
      end

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
