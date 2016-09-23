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

      attribute :logo_graphic_id, xpath: "eveapi/result/logo/graphicID/?[0]", type: :integer
      attribute :logo_shape1,     xpath: "eveapi/result/logo/shape1/?[0]",    type: :integer
      attribute :logo_shape2,     xpath: "eveapi/result/logo/shape2/?[0]",    type: :integer
      attribute :logo_shape3,     xpath: "eveapi/result/logo/shape3/?[0]",    type: :integer
      attribute :logo_color1,     xpath: "eveapi/result/logo/color1/?[0]",    type: :integer
      attribute :logo_color2,     xpath: "eveapi/result/logo/color2/?[0]",    type: :integer
      attribute :logo_color3,     xpath: "eveapi/result/logo/color3/?[0]",    type: :integer

      # @param corporation_id [Integer] EVE corporation ID
      def initialize(corporation_id, opts = {})
        opts[:query_params] = { "corporationID" => corporation_id }
        super(opts)
      end
    end
  end
end
