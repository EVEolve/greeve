require "ox"
require "yaml"

# Spec helpers.
module SpecHelpers
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
