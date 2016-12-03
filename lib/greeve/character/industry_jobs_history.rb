require_relative "../base_item"

module Greeve
  module Character
    # Finished character industry jobs.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/character/char_industryjobshistory.html
    class IndustryJobsHistory < Greeve::BaseItem
      endpoint "char/IndustryJobsHistory"

      rowset :jobs, xpath: "eveapi/result/rowset[@name='jobs']" do
        attribute :job_id,                 xpath: "@jobID",                type: :integer
        attribute :installer_id,           xpath: "@installerID",          type: :integer
        attribute :installer_name,         xpath: "@installerName",        type: :string
        attribute :facility_id,            xpath: "@facilityID",           type: :integer
        attribute :solar_system_id,        xpath: "@solarSystemID",        type: :integer
        attribute :solar_system_name,      xpath: "@solarSystemName",      type: :string
        attribute :station_id,             xpath: "@stationID",            type: :integer
        attribute :activity_id,            xpath: "@activityID",           type: :integer
        attribute :blueprint_id,           xpath: "@blueprintID",          type: :integer
        attribute :blueprint_type_id,      xpath: "@blueprintTypeID",      type: :integer
        attribute :blueprint_type_name,    xpath: "@blueprintTypeName",    type: :string
        attribute :blueprint_location_id,  xpath: "@blueprintLocationID",  type: :integer
        attribute :output_location_id,     xpath: "@outputLocationID",     type: :integer
        attribute :runs,                   xpath: "@runs",                 type: :integer
        attribute :cost,                   xpath: "@cost",                 type: :numeric
        attribute :licensed_runs,          xpath: "@licensedRuns",         type: :integer
        attribute :probability,            xpath: "@probability",          type: :numeric
        attribute :product_type_id,        xpath: "@productTypeID",        type: :integer
        attribute :product_type_name,      xpath: "@productTypeName",      type: :string
        attribute :status,                 xpath: "@status",               type: :integer
        attribute :time_in_seconds,        xpath: "@timeInSeconds",        type: :integer
        attribute :start_date,             xpath: "@startDate",            type: :datetime
        attribute :end_date,               xpath: "@endDate",              type: :datetime
        attribute :pause_date,             xpath: "@pauseDate",            type: :datetime
        attribute :completed_date,         xpath: "@completedDate",        type: :datetime
        attribute :completed_character_id, xpath: "@completedCharacterID", type: :integer
        attribute :successful_runs,        xpath: "@successfulRuns",       type: :integer
      end

      # @param character_id [Integer] EVE character ID
      def initialize(character_id, opts = {})
        opts[:query_params] = { "characterID" => character_id }
        super(opts)
      end
    end
  end
end
