require_relative "../base_item"

module Greeve
  module Corporation
    # Information about the members of a corporation.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/corporation/corp_membertracking.html
    class MemberTracking < Greeve::BaseItem
      endpoint "corp/MemberTracking"

      rowset :members, xpath: "eveapi/result/rowset[@name='members']" do
        attribute :character_id,     xpath: "@characterID",    type: :integer
        attribute :name,             xpath: "@name",           type: :string
        attribute :start_date_time,  xpath: "@startDateTime",  type: :datetime
        attribute :base_id,          xpath: "@baseID",         type: :integer
        attribute :base,             xpath: "@base",           type: :string
        attribute :title,            xpath: "@title",          type: :string
        attribute :logon_date_time,  xpath: "@logonDateTime",  type: :datetime
        attribute :logoff_date_time, xpath: "@logoffDateTime", type: :datetime
        attribute :location_id,      xpath: "@locationID",     type: :integer
        attribute :location,         xpath: "@location",       type: :string
        attribute :ship_type_id,     xpath: "@shipTypeID",     type: :integer
        attribute :ship_type,        xpath: "@shipType",       type: :string
        attribute :roles,            xpath: "@roles",          type: :integer
        attribute :grantable_roles,  xpath: "@grantableRoles", type: :integer
      end

      # @option opts [Boolean] :extended (false) query extended member tracking info
      def initialize(opts = {})
        extended = !!opts.delete(:extended)

        opts[:query_params] = { "extended" => 1 } if extended

        super(opts)
      end
    end
  end
end
