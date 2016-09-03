require_relative "../base_item"

module Greeve
  module API
    # List of all selectable API endpoints/groups to which an API grants
    # access to.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/api/api_calllist.html
    class CallList < Greeve::BaseItem
      endpoint "api/CallList"

      rowset :call_groups, xpath: "eveapi/result/rowset[@name='callGroups']" do
        attribute :group_id,    xpath: "@groupID",     type: :integer
        attribute :name,        xpath: "@name",        type: :string
        attribute :description, xpath: "@description", type: :string
      end

      rowset :calls, xpath: "eveapi/result/rowset[@name='calls']" do
        attribute :access_mask, xpath: "@accessMask",  type: :integer
        attribute :type,        xpath: "@type",        type: :string
        attribute :name,        xpath: "@name",        type: :string
        attribute :group_id,    xpath: "@groupID",     type: :integer
        attribute :description, xpath: "@description", type: :string
      end

      def initialize(opts = {})
        super(opts)
      end
    end
  end
end
