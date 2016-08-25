require_relative "../lib/greeve"

module Greeve
  module Handlers
    # YARD handler for the `endpoint` DSL method.
    class Endpoint < YARD::Handlers::Ruby::Base
      handles method_call(:endpoint)
      namespace_only

      process do
        endpoint = statement.parameters[0].jump(:tstring_content).source

        namespace.add_tag(YARD::Tags::Tag.new(
          :note,
          "Endpoint: #{Greeve::EVE_API_BASE_URL}/#{endpoint}.xml.aspx"
        ))
      end
    end
  end
end
