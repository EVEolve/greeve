require_relative "../base_item"

module Greeve
  module Corporation
    # Availabile contracts for a corporation.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_contracts.html
    class Contracts < Greeve::BaseItem
      endpoint "corp/Contracts"

      rowset :contract_list, xpath: "eveapi/result/rowset[@name='contractList']" do
        attribute :contract_id,      xpath: "@contractID",     type: :integer
        attribute :issuer_id,        xpath: "@issuerID",       type: :integer
        attribute :issuer_corp_id,   xpath: "@issuerCorpID",   type: :integer
        attribute :assignee_id,      xpath: "@assigneeID",     type: :integer
        attribute :acceptor_id,      xpath: "@acceptorID",     type: :integer
        attribute :start_station_id, xpath: "@startStationID", type: :integer
        attribute :end_station_id,   xpath: "@endStationID",   type: :integer
        attribute :type,             xpath: "@type",           type: :string
        attribute :status,           xpath: "@status",         type: :string
        attribute :title,            xpath: "@title",          type: :string
        attribute :for_corp,         xpath: "@forCorp",        type: :boolean
        attribute :availability,     xpath: "@availability",   type: :string
        attribute :date_issued,      xpath: "@dateIssued",     type: :datetime
        attribute :date_expired,     xpath: "@dateExpired",    type: :datetime
        attribute :date_accepted,    xpath: "@dateAccepted",   type: :datetime
        attribute :date_completed,   xpath: "@dateCompleted",  type: :datetime
        attribute :num_days,         xpath: "@numDays",        type: :integer
        attribute :price,            xpath: "@price",          type: :numeric
        attribute :reward,           xpath: "@reward",         type: :numeric
        attribute :colalteral,       xpath: "@collateral",     type: :numeric
        attribute :buyout,           xpath: "@buyout",         type: :numeric
        attribute :volume,           xpath: "@volume",         type: :numeric
      end

      # @option opts [Integer] :contract_id (nil) ID of a specific contract
      def initialize(opts = {})
        contract_id = opts.delete(:contract_id)

        opts[:query_params] = { "contractID" => contract_id } if contract_id

        super(opts)
      end
    end
  end
end
