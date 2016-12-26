require_relative "../base_item"

module Greeve
  module Eve
    # A list of error codes and text that the API may return.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/eve/eve_errorlist.html
    class ErrorList < Greeve::BaseItem
      endpoint "eve/ErrorList"

      rowset :errors, xpath: "eveapi/result/rowset[@name='errors']" do
        attribute :error_code, xpath: "@errorCode", type: :integer
        attribute :error_text, xpath: "@errorText", type: :string
      end
    end
  end
end
