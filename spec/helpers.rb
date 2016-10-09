require "ox"
require "yaml"

# Spec helpers.
module SpecHelpers
  # Stub out an HTTP endpoint to return a canned response.
  #
  # @param endpoint [String, Regexp] full URL of the endpoint to stub
  # @param response_file [String] base name of the file to load as a response
  #   (the .xml extension does not need to be specified)
  #
  # @option opts [Integer] :code (200) HTTP response code to return
  def stub_endpoint(endpoint, response_file, opts = {})
    code = opts[:code] || 200

    typhoeus_opts = {
      params: opts[:params],
      headers: opts[:headers],
    }

    allow(Typhoeus).to receive(:get) {
      Typhoeus::Response.new(code: code, body: load_file(response_file))
    }
  end

  # Stub out the remaining HTTP endpoints with 500 errors so that live HTTP
  # requests aren't sent.
  def invalidate_remaining_endpoints
    # TODO: Figure out a better stubbing strategy, because Typhoeus.stub isn't
    #   playing nicely with RSpec.
    return

    # Typhoeus
    #   .stub(/.*/)
    #   .and_return(Typhoeus::Response.new(code: 500))
  end

  # Parse a cassette's response string in spec/cassettes into an XML element.
  #
  # @param cassette [String] relative path to the cassette (the .yml extension
  #   does not need to be specified)
  #
  # @option opts [String] :xpath (nil) optional xpath of a nested element to
  #   return. The root element is returned if this is not specified.
  #
  # @return [Ox::Element] an XML element
  def load_xml_from_cassette(cassette, opts = {})
    xpath = opts[:xpath]

    cassette_path = "spec/cassettes/#{cassette}.yml"
    response_string = YAML.load_file(cassette_path)["http_interactions"][0]["response"]["body"]["string"]
    element = Ox.parse(response_string)

    xpath ? element.locate(xpath).first : element
  end
end
