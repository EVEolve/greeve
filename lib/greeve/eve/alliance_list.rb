require_relative "../base_item"

module Greeve
  module Eve
    # Returns active alliances in New Eden and their member corporations.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_alliancelist.html
    class AllianceList < Greeve::BaseItem
      endpoint "eve/AllianceList"

      rowset :alliances, xpath: "eveapi/result/rowset[@name='alliances']" do
        attribute :name,             xpath: "@name",           type: :string
        attribute :short_name,       xpath: "@shortName",      type: :string
        attribute :alliance_id,      xpath: "@allianceID",     type: :integer
        attribute :executor_corp_id, xpath: "@executorCorpID", type: :integer
        attribute :member_count,     xpath: "@memberCount",    type: :integer
        attribute :start_date,       xpath: "@startDate",      type: :datetime
      end

      # @param version [Integer] EVE Alliance List
      def initialize(version, opts = {})
        raise ArgumentError, "not implemented, use version=1" if version == 0

        opts[:query_params] = { "version" => version }
        super(opts)
      end
    end
  end
end
