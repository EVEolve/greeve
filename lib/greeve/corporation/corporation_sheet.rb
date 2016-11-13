require_relative "../base_item"

module Greeve
  module Corporation
    # Details for a specific corporation.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_corporationsheet.html
    class CorporationSheet < Greeve::BaseItem
      endpoint "corp/CorporationSheet"

      attribute :corporation_id,   xpath: "eveapi/result/corporationID/?[0]",   type: :integer
      attribute :corporation_name, xpath: "eveapi/result/corporationName/?[0]", type: :string
      attribute :ticker,           xpath: "eveapi/result/ticker/?[0]",          type: :string
      attribute :ceo_id,           xpath: "eveapi/result/ceoID/?[0]",           type: :integer
      attribute :ceo_name,         xpath: "eveapi/result/ceoName/?[0]",         type: :string
      attribute :station_id,       xpath: "eveapi/result/stationID/?[0]",       type: :integer
      attribute :station_name,     xpath: "eveapi/result/stationName/?[0]",     type: :string
      attribute :description,      xpath: "eveapi/result/description/?[0]",     type: :string
      attribute :url,              xpath: "eveapi/result/url/?[0]",             type: :string
      attribute :alliance_id,      xpath: "eveapi/result/allianceID/?[0]",      type: :integer
      attribute :faction_id,       xpath: "eveapi/result/factionID/?[0]",       type: :integer
      attribute :tax_rate,         xpath: "eveapi/result/taxRate/?[0]",         type: :numeric
      attribute :member_count,     xpath: "eveapi/result/memberCount/?[0]",     type: :integer
      attribute :shares,           xpath: "eveapi/result/shares/?[0]",          type: :integer

      namespace :logo, xpath: "eveapi/result/logo" do
        attribute :graphic_id, xpath: "graphicID/?[0]", type: :integer
        attribute :shape1,     xpath: "shape1/?[0]",    type: :integer
        attribute :shape2,     xpath: "shape2/?[0]",    type: :integer
        attribute :shape3,     xpath: "shape3/?[0]",    type: :integer
        attribute :color1,     xpath: "color1/?[0]",    type: :integer
        attribute :color2,     xpath: "color2/?[0]",    type: :integer
        attribute :color3,     xpath: "color3/?[0]",    type: :integer
      end

      # @param corporation_id [Integer] EVE corporation ID
      def initialize(corporation_id, opts = {})
        opts[:query_params] = { "corporationID" => corporation_id }
        super(opts)
      end
    end
  end
end
