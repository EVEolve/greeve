require_relative "../base_item"

module Greeve
  module Eve
    # Returns the names associated with a sequence of typeIDs.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_typename.html
    class TypeName < Greeve::BaseItem
      endpoint "eve/TypeName"

      rowset :types, xpath: "eveapi/result/rowset[@name='types']" do
        attribute :type_id,   xpath: "@typeID",   type: :integer
        attribute :type_name, xpath: "@typeName", type: :string
      end

      # @param ids [Array<Integer>, Integer] EVE type IDs
      #
      # @!method initialize(*ids, opts = {})
      def initialize(*ids)
        opts = ids.last.is_a?(Hash) ? ids.pop : {}

        opts[:query_params] = { "IDs" => ids.join(",") }

        super(opts)
      end
    end
  end
end
